DEPLOYMENT_TARGET = 9.0
CURRENT_SWIFT_VERSION = 4.0
PRODUCT_NAME = "BeaverSample"
COMPANY_IDENTIFIER = "com.beaver"

project do |p|
    p.name = "Sample"
    p.organization = "Beaver"
end

def main_configuration(target, configuration)
    configuration.product_bundle_identifier = COMPANY_IDENTIFIER + "." + target.name
    configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = "iPhone Developer"

    configuration.settings["INFOPLIST_FILE"] = "#{target.name}/Info.plist"

    configuration.settings["PRODUCT_NAME"] = "$(TARGET_NAME)"
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

    configuration.settings["ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"] = "$(inherited)"

    if configuration.name == "Release"
        configuration.settings["DEBUG_INFORMATION_FORMAT"] = "dwarf-with-dsym"
        configuration.settings["SWIFT_OPTIMIZATION_LEVEL"] = "-Owholemodule"
    end
end

def module_target(name, linked_targets=[])
    return target do |target|
        target.name = name
        target.platform = :ios
        target.deployment_target = DEPLOYMENT_TARGET
        target.type = :framework
        target.language = :swift
        target.include_files = ["Module/#{target.name}/#{target.name}/**/*.*"]
        target.exclude_files << "**/Info.plist"
        target.linked_targets = linked_targets
        target.system_frameworks << "UIKit"

        unit_tests_for target do |test_target|
            test_target.name = "#{target.name}Tests"
            test_target.include_files = ["Module/#{target.name}/#{target.name}Tests/**/*.*"]
            target.exclude_files << "**/Info.plist"

            test_target.all_configurations do |configuration|
                main_configuration(test_target, configuration)
                configuration.settings["INFOPLIST_FILE"] = "Module/#{target.name}/#{test_target.name}/Info.plist"
                configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = ""
            end
        end

        target.all_configurations.each do |configuration|
            main_configuration(target, configuration)
            configuration.settings["INFOPLIST_FILE"] = "Module/#{target.name}/#{target.name}/Info.plist"
            configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = ""
        end
    end	
end

core_target = module_target("Core")
api_target = module_target("API", [core_target])
home_target = module_target("Home", [core_target, api_target])
movie_card_target = module_target("MovieCard", [core_target, api_target])

application_for :ios, DEPLOYMENT_TARGET do |target|
    target.name = "Sample"
    target.language = :swift
    target.include_files = ["Sample/**/*.*"]

    target.linked_targets = [
        core_target,
        api_target,
        home_target,
        movie_card_target
    ]

    target.all_configurations.each do |configuration|
        main_configuration(target, configuration)

        configuration.supported_devices = :universal

    end

    unit_tests_for target do |test_target|
        test_target.name = "SampleTests"
        test_target.include_files = ["SampleTests/**/*.*"]

        test_target.all_configurations do |configuration|
            main_configuration(target, configuration)
            configuration.settings["INFOPLIST_FILE"] = "#{test_target.name}/Info.plist"
            configuration.settings["DEFINES_MODULE"] = "YES"
            configuration.settings["CODE_SIGN_IDENTITY[sdk=iphoneos*]"] = ""
        end
    end
end

project.after_save do
    `pod install`
end
