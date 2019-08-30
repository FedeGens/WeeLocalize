Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "WeeMenu"
s.summary = "WeeMenu is a fast and easy-to-use SideMenu for iOS."
s.requires_arc = true
s.swift_version = '4.2'

# 2
s.version = "0.0.10"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Federico Gentile" => "fgentile95dev@icloud.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/FedeGens/WeeMenu"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/FedeGens/WeeMenu.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"

# 8
s.source_files = "WeeMenu/*.{swift}"

end
