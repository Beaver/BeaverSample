import Beaver

public protocol MovieCardAction: Beaver.Action {
}

public enum MovieCardRoutingAction: MovieCardAction {
    case start
    case stop
}

enum MovieCardUIAction: MovieCardAction {
    case finish
}
