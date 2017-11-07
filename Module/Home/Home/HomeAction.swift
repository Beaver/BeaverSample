import Beaver

public protocol HomeAction: Beaver.Action {
}

public enum HomeRoutingAction: HomeAction {
    case start
    case stop
}

enum HomeUIAction: HomeAction {
    case finish
}
