#
# Be sure to run `pod lib lint AiryRefreshControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AiryRefreshControl"
  s.version          = "1.0.0"
  s.summary          = "iOS pull down & pull up refresh control"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        iOS pull down & pull up refresh control that is used with UIScrollView
                        DESC

  s.homepage         = "https://github.com/airymiao/AiryRefreshControl"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "airymiao" => "airymiao@gmail.com" }
  s.source           = { :git => "https://github.com/airymiao/AiryRefreshControl.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/airymiao'

  s.ios.deployment_target = '7.0'

  s.source_files = 'AiryRefreshControl/Classes/**/*'
  s.resource_bundles = {
    'AiryRefreshControl' => ['AiryRefreshControl/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
