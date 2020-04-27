# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!

def shared_pods
   pod 'IQKeyboardManagerSwift'
   pod 'MaterialComponents'
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
