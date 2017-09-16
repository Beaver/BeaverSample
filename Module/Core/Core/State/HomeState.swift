import Beaver

public struct HomeState: State {
    // MARK: - SubTypes

    public enum CurrentController {
        case main
        case movieCard(id: Int, title: String)
        case none
    }

    public struct MovieState {
        public var id: Int
        public var title: String
        
        public init(id: Int,
                    title: String) {
            self.id = id
            self.title = title
        }
    }

    // MARK: - Attributes

    public var error: String?

    public var currentController: CurrentController = .none
    public var movies: [MovieState]?
    public var page: Int = 1
    public var hasNextMovies: Bool = true

    // MARK: - Init

    public init() {
    }
}

// MARK: - Equatable

extension HomeState {
    public static func ==(lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentController == rhs.currentController &&
            lhs.movies === rhs.movies &&
            lhs.page == rhs.page &&
            lhs.hasNextMovies == rhs.hasNextMovies
    }
}

extension HomeState.MovieState: Equatable {
    public static func ==(lhs: HomeState.MovieState, rhs: HomeState.MovieState) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}

extension HomeState.CurrentController: Equatable {
    public static func ==(lhs: HomeState.CurrentController, rhs: HomeState.CurrentController) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main),
             (.none, .none):
            return true
        case (.movieCard(let leftId, let leftTitle),
              .movieCard(let rightId, let rightTitle)):
            return leftId == rightId && leftTitle == rightTitle
        default:
            return false
        }
    }
}
