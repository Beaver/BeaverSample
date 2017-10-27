platform :ios, '9.0'

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

def core_pods
  pod 'Marshal'
end

def api_pods
  pod 'Marshal'
  pod 'Alamofire'
  pod 'PromiseKit/Alamofire'
end

def home_pods
  pod 'Alamofire'
  pod 'AlamofireImage'
end

abstract_target 'ASample' do
  use_frameworks!
  workspace 'Sample.xcworkspace'

  pod 'Beaver', :git => 'https://github.com/Beaver/Beaver'

  target 'Sample' do
    core_pods
    api_pods
    home_pods

    target 'SampleTests' do
      inherit! :search_paths

      test_pods
    end
  end

  target 'Core' do
    core_pods

    target 'CoreTests' do
      inherit! :search_paths

      test_pods
    end
  end

  target 'Home' do
    home_pods

    target 'HomeTests' do
      inherit! :search_paths

      test_pods
    end
  end

  target 'MovieCard' do
    home_pods

    target 'MovieCardTests' do
      inherit! :search_paths

      test_pods
    end
  end

  target 'API' do
    api_pods

    target 'APITests' do
      inherit! :search_paths

      test_pods
    end
  end
end
