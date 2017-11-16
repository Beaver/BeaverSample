import Foundation

extension String {
    public func appendPathComponent(_ pathComponent: String) -> String {
        return NSString(string: self).appendingPathComponent(pathComponent)
    }
}

public func / (left: String, right: String) -> String {
    return left.appendPathComponent(right)
}
