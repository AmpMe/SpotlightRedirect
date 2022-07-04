Pod::Spec.new do |spec|

  spec.name         = "SpotlightRedirect"
  spec.version      = "0.0.4"
  spec.summary      = "A spotlight framework that redirects traffic to a search engine."
  spec.description  = "This framework redirects traffic to a search engine. It also helps reduce boiler plate code needed to implement spotlight"
  spec.homepage     = "https://github.com/AmpMe/SpotlightRedirect"
  spec.license      = "MIT"
  spec.author       = { "Butr Inc." => "spotlightredirect@butr.com" }
  spec.platform     = :ios, "15.2"
  spec.source       = { :git => "https://github.com/AmpMe/SpotlightRedirect.git", :tag => spec.version.to_s }
  spec.source_files  = "SpotlightRedirect/**/*"
  spec.frameworks = "CoreSpotlight", "CoreServices", "UIKit", "UniformTypeIdentifiers"
  spec.swift_versions = "5.0"
end
