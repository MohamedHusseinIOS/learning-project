# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'etajerIOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for etajerIOS

  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'RxDataSources', '~> 3.1.0'
  pod 'SlideMenuControllerSwift'
  pod 'Cosmos', '~> 19.0'
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'SkeletonView'
  pod 'SVProgressHUD'
  pod 'Kingfisher', '~> 5.0'
  
  pod 'GooglePlaces'
  pod 'GoogleMaps'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if 'SlideMenuControllerSwift'.include? target.name
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.0'
        end
      end
    end
  end
	
end
