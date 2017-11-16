def home_pods
	pod 'Alamofire'
	pod 'AlamofireImage'
end

def home_target
    target 'Home' do
        core_pods
        home_pods

        target 'HomeTests' do
            inherit! :search_paths

            test_pods
        end
    end
end
