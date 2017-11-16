def api_pods
	pod 'Marshal'
	pod 'Alamofire'
	pod 'PromiseKit/Alamofire'
end

def api_target
    target 'API' do
        
        api_pods

        target 'APITests' do
            inherit! :search_paths

            test_pods
        end
    end
end
