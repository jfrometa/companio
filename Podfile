# Uncomment the next line to define a global platform for your project
# add pods for any other desired Firebase products
# https://firebase.google.com/docs/ios/setup#available-pods

platform :ios, '12.0'
use_frameworks!

def shared_pods
   pod 'IQKeyboardManagerSwift'
   pod 'MaterialComponents'
   pod 'Firebase/Analytics'
   pod 'Firebase/Auth'
   pod 'Firebase/Crashlytics'

end

target 'DotVet' do
  use_frameworks!
  shared_pods

  target 'DotVetTests' do
    inherit! :search_paths
  end

  target 'DotVetUITests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['ENABLE_BITCODE'] = 'YES'
        config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end
