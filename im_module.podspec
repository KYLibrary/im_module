#
# Be sure to run `pod lib lint im_module.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'im_module'
  s.version          = '0.1.0'
  s.summary          = 'A short description of im_module.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  IM 模块
                       DESC

  s.homepage         = 'https://github.com/KYLibrary/im_module'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kyleboy' => 'iyinghui@163.com' }
  s.source           = { :git => 'https://github.com/KYLibrary/im_module.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.default_subspec         = "Helper"
  s.ios.deployment_target = '9.0'
  

  s.prefix_header_contents = <<-EOS

   #import <Hyphenate/Hyphenate.h>
   #import "EMHeaders.h"
   #import "UIImage+MWPhotoBrowser.h"
   #import "UIImage+KYAdd.h"
   
  EOS

  s.subspec "Helper" do |ss|
    ss.dependency 'Masonry'
    ss.dependency 'MJRefresh'
    ss.dependency 'MBProgressHUD'
    ss.dependency 'SDWebImage/GIF'
    ss.dependency 'FLAnimatedImage'
    ss.dependency 'Hyphenate', '3.6.5'
    ss.dependency 'KYUtil/KYCategories'
    ss.source_files         = "im_module/Helper/**/*.{h,m}"
    ss.resource_bundles = {
        'Helper' => [
        'im_module/Helper/**/*.png',
        ]
    }
  end
  s.subspec "Chat" do |ss|
      ss.dependency 'im_module/Helper'
      ss.dependency 'KYVoiceConvert', '~> 0.1.0'
      ss.dependency 'KYPhotoBrowser', '~> 0.1.1'
      ss.dependency 'FLAnimatedImage', '~> 1.0'
      ss.source_files         = "im_module/Chat/**/*.{h,m,mm}"
      #ss.exclude_files        = "**/__tests__/*",
      ss.resource_bundles = {
          'Chat' => [
          'im_module/Chat/**/*.{png,gif}',
          ]
      }
  end

  s.subspec "Conversation" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Conversation/**/*.{h,m,mm}"
  end
  
  s.subspec "Account" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Account/**/*.{h,m,mm}"
      #ss.exclude_files        = "**/__tests__/*",
      ss.resource_bundles = {
          'Account' => [
          'im_module/Account/**/*.png',
          ]
      }
  end
  
  s.subspec "Call" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Call/**/*.{h,m,mm}"
      #ss.exclude_files        = "**/__tests__/*",
      ss.resource_bundles = {
          'Call' => [
          'im_module/Call/**/*.png',
          ]
      }
  end
  
  s.subspec "Chatroom" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Chatroom/**/*.{h,m,mm}"
      #ss.exclude_files        = "**/__tests__/*",
      ss.resource_bundles = {
          'Chatroom' => [
          'im_module/Chatroom/**/*.png',
          ]
      }
  end
  
  s.subspec "Contact" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Contact/**/*.{h,m}"
      ss.resource_bundles = {
          'Contact' => [
          'im_module/Contact/**/*.png',
          ]
      }
  end
  
  s.subspec "Group" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Group/**/*.{h,m,mm}"
      ss.resource_bundles = {
          'Group' => [
          'im_module/Group/**/*.png',
          ]
      }
  end
  
  s.subspec "Notification" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Notification/**/*.{h,m}"
  end
  
  s.subspec "Settings" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Settings/**/*.{h,m}"
  end
  
  s.subspec "Home" do |ss|
      ss.dependency 'im_module/Helper'
      ss.source_files         = "im_module/Home/**/*.{h,m}"
      ss.resource_bundles = {
          'Home' => [
          'im_module/Home/**/*.png',
          ]
      }
  end
end
