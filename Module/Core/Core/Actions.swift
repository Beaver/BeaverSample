import Beaver

// MARK: - App Actions

public enum AppAction: Action {
    case start(withFirstAction: Action)
    case stop(withLastAction: Action)
}

// MARK: - Home Actions

public protocol HomeAction: Action {
}

public enum HomeRoutingAction: HomeAction {
    case start
    case stop
}

// MARK: - MovieCard Actions

public protocol MovieCardAction: Action {
}

public enum MovieCardRoutingAction: MovieCardAction {
    case start(id: Int, title: String)
    case stop
}
