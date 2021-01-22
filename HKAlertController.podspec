Pod::Spec.new do |s|
  s.name             = 'HKAlertController'
  s.version          = '0.1.0'
  s.summary          = 'Alert Controller Fully Customized.'

  s.description      = <<-DESC
  Alert controller fully customized.
  * Support Window Level Show and Dismiss.
  * Support Horizontal and Vertical UI Layout.
  * Support Animations Extend. (Default is FadeInOut.)
                       DESC

  s.homepage         = 'https://github.com/HarkenxX/HKAlertController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'harken' => 'harkenx@foxmail.com' }
  s.source           = { :git => 'https://github.com/HarkenxX/HKAlertController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'HKAlertController/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  
  s.dependency "Masonry"
end
