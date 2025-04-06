require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-video360"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-video360
                   DESC
  s.homepage     = "https://github.com/azesmway/react-native-video360"
  s.license      = "MIT"
  s.authors      = { "Nick" => "azesm.way@gmail.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/azesmway/react-native-video360", :tag => "#{s.version}" }

  s.ios.framework = 'AudioToolbox','CoreMedia','VideoToolbox'

  s.ios.library = 'bz2.1.0','iconv.2','z.1'
  s.source_files = "ios/**/*.{h,m,swift}"
  s.resources = ['ios/*.{xib}']

  s.resource_bundles = {
    'Resources' => ['ios/*.xcassets']
  }

  s.requires_arc = true

  s.dependency "React"
  s.dependency 'SGPlayerVR'
end

