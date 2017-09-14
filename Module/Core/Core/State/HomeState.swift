import Beaver

public struct HomeState: State {
    // MARK: - SubTypes

    public enum CurrentStage {
        case main
        case movieCard(id: Int, title: String, imageURL: String, overview: String)
        case none
    }

    public struct MovieState {
        public var id: Int
        public var title: String
        public var voteAverage: String
        public var releaseDate: String
        public var posterPath: String
        public var backdropPath: String
        public var overview: String

        public var imageURL: String {
            return "https://image.tmdb.org/t/p/w500/" + posterPath
        }
    }

    // MARK: - Attributes

    public var error: String?

    public var currentStage: CurrentStage = .none
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
            lhs.currentStage == rhs.currentStage &&
            lhs.movies === rhs.movies &&
            lhs.page == rhs.page &&
            lhs.hasNextMovies == rhs.hasNextMovies
    }
}

extension HomeState.MovieState: Equatable {
    public static func ==(lhs: HomeState.MovieState, rhs: HomeState.MovieState) -> Bool {
        return lhs.id == rhs.id
    }
}

extension HomeState.CurrentStage: Equatable {
    public static func ==(lhs: HomeState.CurrentStage, rhs: HomeState.CurrentStage) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main),
             (.none, .none):
            return true
        case (.movieCard(let leftId, let leftTitle, let leftImageURL, let leftOverview),
              .movieCard(let rightId, let rightTitle, let rightImageURL, let rightOverview)):
            return leftId == rightId && leftTitle == rightTitle && leftImageURL == rightImageURL && leftOverview == rightOverview
        default:
            return false
        }
    }
}
