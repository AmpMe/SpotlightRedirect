//
//  SpotlightRedirectSingleton.swift
//  SpotlightRedirect
//
//  Created by Shamari Ishmael on 6/28/22.
//

import Foundation
import CoreSpotlight
import CoreServices
import UIKit
import UniformTypeIdentifiers

public struct SpotlightRedirectConfig {
    var filePath: String
    
    public init(filePath: String) {
        self.filePath = filePath
    }
}

public class SpotlightRedirectSingleton {
    public static let shared = SpotlightRedirectSingleton()
    
    public static var config: SpotlightRedirectConfig?
    
    public class func setup(_ config: SpotlightRedirectConfig) {
        SpotlightRedirectSingleton.config = config
        
        SpotlightRedirectSingleton.shared.indexKeywordsInBackground()
    }
    
    public init() {
        guard let _ = SpotlightRedirectSingleton.config else {
            fatalError("Error - you must call setup before accessing SpotlightRedirectSingleton.shared")
        }
        print("Successfully Initialized SpotlightRedirectSingleton")
    }
    
    
    
    private func indexKeywords() {
        // Delete index first
        CSSearchableIndex.default().deleteAllSearchableItems { error in
            if error != nil {
                print(error?.localizedDescription ?? "error deleting all searchable items")
            } else {
                // At this stage the index has been deleted
                var searchableItems: [CSSearchableItem] = []
                
                guard let filePath = SpotlightRedirectSingleton.config?.filePath else {
                    return
                }
                
                var csvData = ""
                do {
                    csvData = try String(contentsOfFile: filePath)
                } catch {
                    print(error)
                    return
                }
                
                var rows = csvData.components(separatedBy: "\n")
                
                rows.removeFirst()
                
                for row in rows {
                    let columns = row.components(separatedBy: ",")
                    
                    if columns.count == 3 {
                        let spotlightTerm = columns[0]
                        let searchTerm = columns[1]
                        let country = columns[2].replacingOccurrences(of: "\r", with: "")
                        
                        let deviceCountry = Locale.current.regionCode
                        
                        if deviceCountry?.uppercased() == country.uppercased() {
                            let attributeSet = CSSearchableItemAttributeSet(contentType: .text)
                            
                            attributeSet.title = spotlightTerm
                            attributeSet.contentDescription = searchTerm
                            attributeSet.country = country
                            
                            let item = CSSearchableItem(uniqueIdentifier: searchTerm, domainIdentifier: nil, attributeSet: attributeSet)
                            searchableItems.append(item)
                        }
                    }
                }
                
                NSLog("Spotlight: Indexing Started for \(searchableItems.count) items")
                CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
                    if error != nil {
                        NSLog(error?.localizedDescription ?? "error indexing searchable items")
                    } else {
                        // Indexing finish
                        NSLog("Spotlight: Indexing Finished for \(searchableItems.count) items")
                    }
                }
            }
        }
    }
    
    public func indexKeywordsInBackground() {
        DispatchQueue.global(qos: .background).async {
            self.indexKeywords()
        }
    }
    
    public func application(continue userActivity: NSUserActivity) {
        if userActivity.activityType == CSSearchableItemActionType {
            if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
               let url = URL(string: "https://www.bing.com/search?q=\(uniqueIdentifier)") {
                UIApplication.shared.open(url)
            }
        }
    }
}
