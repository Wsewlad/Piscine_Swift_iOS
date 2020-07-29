#
# Be sure to run `pod lib lint vfil2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'vfil2019'
  s.version          = '0.1.0'
  s.summary          = 'A pod for Article Manager'
  s.swift_version    = '4.0.3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This pod is integrated with CoreData and used for Article Manager. Project of Piscine Swift iOS.
                        DESC

  s.homepage         = 'https://github.com/Wsewlad/vfil2019'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wsewlad' => 'wladyslawfil@gmail.com' }
  s.source           = { :git => 'https://github.com/Wsewlad/vfil2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'vfil2019/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'vfil2019' => ['vfil2019/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
