import Beaver
import Core

public struct MovieCardReducer: Beaver.ChildReducing {
    public typealias ActionType = MovieCardAction
    public typealias StateType = MovieCardState

    public init() {
    }

    public func handle(action: MovieCardAction,
                       state: MovieCardState,
                       completion: @escaping (MovieCardState) -> ()) -> MovieCardState {
        var newState = state

        switch action {
        case MovieCardRoutingAction.start:
            newState.currentScreen = .main

        case MovieCardRoutingAction.stop:
            newState.currentScreen = .none

        default:
            break
        }

        return newState
    }
}
