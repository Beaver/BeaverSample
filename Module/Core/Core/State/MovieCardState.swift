import Beaver

public struct MovieCardState: State {
    // MARK: - SubTypes
    
    public enum CurrentController {
        case none
        case main
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
    public var movie: MovieState?
    
    // MARK: - Inits
    
    public init() {
    }
}

// MARK: - Equatable

extension MovieCardState {
    public static func ==(lhs: MovieCardState, rhs: MovieCardState) -> Bool {
        return lhs.error == rhs.error &&
            lhs.currentController == rhs.currentController &&
            lhs.movie == rhs.movie
    }
}

extension MovieCardState.MovieState: Equatable {
    public static func ==(lhs: MovieCardState.MovieState, rhs: MovieCardState.MovieState) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
}
