import Beaver

public struct AppState: State {
    // MARK: - Attributes

    var homeState: HomeState?

    // MARK: - Equatable

    public static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return lhs.homeState == rhs.homeState
    }
}
