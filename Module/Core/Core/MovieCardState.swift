import Beaver

public struct MovieCardState: Beaver.State {
    public var error: String?

    public var currentScreen: CurrentScreen = .none

    public init() {
    }
}

extension MovieCardState {
    /// Represents the currently shown screen
    public enum CurrentScreen {
        case none
        case main(id: Int, title: String)
    }
}

extension MovieCardState {
    public static func ==(lhs: MovieCardState, rhs: MovieCardState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentScreen == rhs.currentScreen
    }
}

extension MovieCardState.CurrentScreen: Equatable {
    public static func ==(lhs: MovieCardState.CurrentScreen, rhs: MovieCardState.CurrentScreen) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.main(let leftId, let leftTitle), .main(let rightId, let rightTitle)):
            return leftId == rightId && leftTitle == rightTitle
        default:
            return false
        }
    }
}
