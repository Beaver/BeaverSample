import Beaver
import Core

public struct MovieCardReducer: ChildReducing {
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
            newState.currentController = .main
            newState.movie = MovieCardState.MovieState(id: id, title: title)
        
        default: break
        }
        
        return newState
    }
}
