import Beaver
import Home

public struct AppState: State {
    var homeState: HomeState?
}

extension AppState {
    public static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return lhs.homeState == rhs.homeState
    }
}