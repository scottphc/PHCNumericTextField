#
# Be sure to run `pod lib lint PHCNumericTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PHCNumericTextField'
  s.version          = '0.1.3'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'A UITextField with the decimal format.'
  s.ios.deployment_target = '7.0'
  s.homepage         = 'https://github.com/scottphc/PHCNumericTextField'
  s.author           = { 'Scott Chou' => 'scott.ph.chou@gmail.com' }
  s.source           = { :git => 'https://github.com/scottphc/PHCNumericTextField.git', :tag => s.version.to_s }

  s.source_files = 'PHCNumericTextField/**/*'
end
