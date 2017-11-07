import Beaver

public struct HomeState: Beaver.State {
    public var error: String?

    public var currentScreen: CurrentScreen = .none

    public init() {
    }
}

extension HomeState {
    /// Represents the currently shown screen
    public enum CurrentScreen: Int {
        case none
        case main
    }
}

extension HomeState {
    public static func ==(lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentScreen == rhs.currentScreen
    }
}
