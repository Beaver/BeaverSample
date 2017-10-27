DEPLOYMENT_TARGET = 9.0
CURRENT_SWIFT_VERSION = 4.0
PRODUCT_NAME = "BeaverSample"
COMPANY_IDENTIFIER = "com.beaver"

project do |p|
	p.name = "Sample"
	p.organization = "Beaver"
end

def main_configuration(target, configuration, is_module=true)
	configuration.product_bundle_identifier = COMPANY_IDENTIFIER + "." + target.name
	configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = "iPhone Developer"
	
	if is_module
	    configuration.settings["INFOPLIST_FILE"] = "Module/#{target.name}/#{target.name}/Info.plist"
	else
	    configuration.settings["INFOPLIST_FILE"] = "#{target.name}/Info.plist"
	end
	
    configuration.settings["PRODUCT_NAME"] = PRODUCT_NAME
    configuration.settings["SWIFT_VERSION"] = CURRENT_SWIFT_VERSION

	configuration.settings["SDKROOT"] = "iphoneos"
    configuration.settings["DEBUG_INFORMATION_FORMAT"] = "dwarf"
    configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = "iPhone Developer"
    configuration.settings["TARGETED_DEVICE_FAMILY"] = "1,2"
    configuration.settings["IPHONEOS_DEPLOYMENT_TARGET"] = DEPLOYMENT_TARGET
    configuration.settings["VERSIONING_SYSTEM"] = "apple-generic"

    configuration.settings["GCC_NO_COMMON_BLOCKS"] = "YES"
    configuration.settings["GCC_WARN_ABOUT_RETURN_TYPE"] = "YES_ERROR"
    configuration.settings["GCC_WARN_UNINITIALIZED_AUTOS"] = "YES_AGGRESSIVE"
    configuration.settings["CLANG_WARN_DIRECT_OBJC_ISA_USAGE"] = "YES_ERROR"
    configuration.settings["CLANG_WARN_OBJC_ROOT_CLASS"] = "YES_ERROR"

    configuration.settings["SWIFT_OPTIMIZATION_LEVEL"] = "-Onone"

    configuration.settings["CURRENT_PROJECT_VERSION"] = "1"

    configuration.settings["CLANG_WARN_INFINITE_RECURSION"] = "YES"
    configuration.settings["CLANG_WARN_SUSPICIOUS_MOVE"] = "YES"
    configuration.settings["ENABLE_STRICT_OBJC_MSGSEND"] = "YES"

    if configuration.name == "Release"
        configuration.settings["DEBUG_INFORMATION_FORMAT"] = "dwarf-with-dsym"
        configuration.settings["SWIFT_OPTIMIZATION_LEVEL"] = "-Owholemodule"
    end
end

def module_target(name)
	target do |target|
		target.name = name
		target.platform = :ios
		target.deployment_target = DEPLOYMENT_TARGET
		target.type = :framework
		target.language = :swift
		target.include_files = ["Module/#{target.name}/#{target.name}/**/*.*"]
		target.exclude_files << "**/Info.plist"

		unit_tests_for target do |test_target|
	        test_target.name = "#{target.name}Tests"
	        test_target.include_files = ["Module/#{target.name}/#{target.name}Tests/**/*.*"]
	    end

		target.all_configurations.each do |configuration|
			main_configuration(target, configuration)
	    end
	end	
end

application_for :ios, DEPLOYMENT_TARGET do |target|
	target.name = "Sample"
	target.language = :swift
	target.include_files = ["Sample/**/*.*"]

	target.linked_targets = [
		module_target("Core"), 
		module_target("API"),
		module_target("Home"),
		module_target("MovieCard")
	]

	target.all_configurations.each do |configuration|
		main_configuration(target, configuration, false)
    end

	unit_tests_for target do |test_target|
        test_target.name = "SampleTests"
        test_target.include_files = ["SampleTests/**/*.*"]
    end
end

project.after_save do
    `pod install`
end