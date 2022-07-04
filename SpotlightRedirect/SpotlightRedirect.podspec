Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "SpotlightRedirect"
  spec.version      = "0.0.1"
  spec.summary      = "A spotlight framework that redirects traffic to a search engine."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  This framework redirects traffic to a search engine. It also helps reduce boiler plate code needed to implement spotlight.
                   DESC

  spec.homepage     = "https://github.com/AmpMe/SpotlightRedirect"
  spec.license      = "MIT"

  spec.author             = { "Butr Inc." => "spotlightredirect@butr.com" }

  spec.platform     = :ios, "15.2"

  spec.source       = { :git => "https://github.com/AmpMe/SpotlightRedirect.git", :tag => spec.version.to_s }

  spec.source_files  = "SpotlightRedirect/**/*.{swift}"

  spec.frameworks = "CoreSpotlight", "CoreServices", "UIKit", "UniformTypeIdentifiers"
  
  spec.swift_versions = "5.0"
end
