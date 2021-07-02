Pod::Spec.new do |s|
  s.name         = "KBLibrary"
  s.version      = "1.0.0"
  s.ios.deployment_target = '9.0'
  s.summary      = "iOS develop tools"
  s.homepage     = "https://github.com/LKeBing/KBLibrary"
  s.license      = "MIT"
  s.author       = { "LKeBing" => "13568922114@163.com" }
  s.source       = { :git => 'https://github.com/LKeBing/KBLibrary.git', :tag => s.version}
  s.requires_arc = true
  s.ios.frameworks = 'Foundation', 'UIKit','AVFoundation'

  s.source_files = 'KBLibrary'

end
