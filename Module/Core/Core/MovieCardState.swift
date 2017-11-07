import Beaver

public struct MovieCardState: Beaver.State {
    public var error: String?

    public var currentScreen: CurrentScreen = .none

    public init() {
    }
}

extension MovieCardState {
    /// Represents the currently shown screen
    public enum CurrentScreen: Int {
        case none
        case main
    }
}

extension MovieCardState {
    public static func ==(lhs: MovieCardState, rhs: MovieCardState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentScreen == rhs.currentScreen
    }
}
