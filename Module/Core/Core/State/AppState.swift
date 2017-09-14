import Beaver

public struct AppState: State {
    // MARK: - Attributes

    public var homeState: HomeState?
    
    // MARK: - Init
    
    public init() {
    }

    // MARK: - Equatable

    public static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return lhs.homeState == rhs.homeState
    }
}
