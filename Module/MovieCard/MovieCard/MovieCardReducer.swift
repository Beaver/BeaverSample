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
        case MovieCardRoutingAction.start(let id, let title):
            newState.currentScreen = .main(id: id, title: title)

        case MovieCardRoutingAction.stop:
            newState.currentScreen = .none
            
        case MovieCardUIAction.finish:
            newState.currentScreen = .none

        default:
            break
        }

        return newState
    }
}
