platform :ios, '9.0'
use_frameworks!

target 'ios-flickr-api-demo' do
pod 'Alamofire'
pod 'ObjectMapper', '~> 2.2'
pod 'AlamofireImage'
end

target 'ios-flickr-api-demoTests' do
pod 'ObjectMapper', '~> 2.2'
end

plugin 'cocoapods-keys', {
  :project => "ios-flickr-api-demo",
  :keys => [
    "api_key"
]}
