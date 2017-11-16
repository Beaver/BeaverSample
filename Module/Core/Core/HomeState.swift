import Beaver

public struct HomeState: Beaver.State {
    public var error: String?

    public var currentScreen: CurrentScreen = .none
    public var movies: [MovieState]?
    public var page: Int = 1
    public var hasNextMovies: Bool = true
    
    public init() {
    }
}

extension HomeState {
    /// Represents the currently shown screen
    public enum CurrentScreen {
        case none
        case main
        case movieCard(id: Int, title: String)
    }
}

extension HomeState {
    public struct MovieState {
        public var id: Int
        public var title: String
        
        public init(id: Int,
                    title: String) {
            self.id = id
            self.title = title
        }
    }
}

extension HomeState {
    public static func ==(lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentScreen == rhs.currentScreen &&
            lhs.movies === rhs.movies &&
            lhs.page == rhs.page &&
            lhs.hasNextMovies == rhs.hasNextMovies
    }
}

extension HomeState.CurrentScreen {
    public static func ==(lhs: HomeState.CurrentScreen, rhs: HomeState.CurrentScreen) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
             (.main, .main):
            return true
        case (.movieCard(let leftId, let leftTitle), .movieCard(let rightId, let rightTitle)):
            return leftId == rightId && leftTitle == rightTitle
        default:
            return false
        }
    }
}

extension HomeState.MovieState: Equatable {
    public static func ==(lhs: HomeState.MovieState, rhs: HomeState.MovieState) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}

