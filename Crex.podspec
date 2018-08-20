#
# Be sure to run `pod lib lint Crex.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Crex'
  s.version          = '0.1.0'
  s.summary          = 'Crex is an library for simple and type safe usage of Notification Center. Posting extra information is so handy due to code completion.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rogowskimark/Crex'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rogowskimark' => 'rogowski.mark@gmail.com' }
  s.source           = { :git => 'https://github.com/rogowskimark/Crex.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.3'
  s.source_files = 'Crex/Classes/**/*'
end
