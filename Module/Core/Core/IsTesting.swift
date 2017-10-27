import Foundation

public var isTesting: Bool {
    #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return true
        }
    #endif
    return false
}
