import Beaver

public protocol MovieCardAction: Beaver.Action {
}

public enum MovieCardRoutingAction: MovieCardAction {
    case start(id: Int, title: String)
    case stop
}
