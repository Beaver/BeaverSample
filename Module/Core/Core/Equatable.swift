import Foundation

public protocol EquatableByDescription: Equatable {
}

public func ==<T: EquatableByDescription>(left: T, right: T) -> Bool {
    return "\(left)" == "\(right)"
}
