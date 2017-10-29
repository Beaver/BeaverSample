def movie_card_target()
 	target do |target|
	    target.name = "MovieCard"
	    target.platform = :ios
	    target.deployment_target = $DEPLOYMENT_TARGET
	    target.type = :framework
	    target.language = :swift
	    target.include_files = ["Module/#{target.name}/#{target.name}/**/*.*"]
	    target.exclude_files << "**/Info.plist"
	    target.linked_targets = [module_target(:core), module_target(:api)]

	    unit_tests_for target do |test_target|
	        test_target.name = "#{target.name}Tests"
	        test_target.include_files = ["Module/#{target.name}/#{target.name}Tests/**/*.*"]
	        target.exclude_files << "**/Info.plist"

	        test_target.all_configurations do |configuration|
	            main_configuration(test_target, configuration)
	            configuration.settings["INFOPLIST_FILE"] = "Module/#{target.name}/#{test_target.name}/Info.plist"
	        end
	    end

	    target.all_configurations.each do |configuration|
	        main_configuration(target, configuration)
	        configuration.settings["INFOPLIST_FILE"] = "Module/#{target.name}/#{target.name}/Info.plist"
	    end
	end
end