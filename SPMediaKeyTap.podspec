#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = 'SPMediaKeyTap'
  s.version      = '0.1.0'
  s.summary      = 'SPMediaKeyTap is a global event tap for the play/pause, prev and next keys on the keyboard.'

  s.homepage     = 'https://github.com/nevyn/SPMediaKeyTap'
  s.license      = 'MIT'
  s.author       = { 'Joachim Bengtsson' => 'joachimb@gmail.com' }
  s.source       = { :git => "https://github.com/nevyn/SPMediaKeyTap.git", :tag => s.version.to_s }

  s.platform     = :osx, '10.5'
  s.osx.deployment_target = '10.5'
  s.requires_arc = false

  s.source_files = 'Classes/**/*.m'

  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
