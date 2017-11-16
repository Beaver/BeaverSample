def core_pods
	pod 'Marshal'
end

def core_target
    target 'Core' do
        
        core_pods

        target 'CoreTests' do
            inherit! :search_paths

            test_pods
        end
    end
end
