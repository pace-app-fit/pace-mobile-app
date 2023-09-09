# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
project 'Pace.xcodeproj'

target 'Pace' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Finetic
pod 'Resolver'
 pod 'Disk', '~> 0.6.4'
pod 'URLImage'
pod 'Firebase/Auth'
pod 'FirebaseUI/Google'
pod 'FirebaseUI/Facebook'
pod 'FirebaseUI/OAuth' # Used for Sign in with Apple, Twitter, etc
pod 'FirebaseUI/Phone'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'FirebaseFirestoreSwift', '~> 7.0-beta'

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

end
