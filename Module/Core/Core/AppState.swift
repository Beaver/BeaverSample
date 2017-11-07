import Beaver

public struct AppState: Beaver.State {
    public var homeState: HomeState?
    public var movieCardState: MovieCardState?

    public init() {
    }
}

extension AppState {
    public static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return lhs.homeState == rhs.homeState &&
            lhs.movieCardState == rhs.movieCardState
    }
}
