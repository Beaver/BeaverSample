import Beaver
import Core

public struct HomeReducer: ChildReducing {
    public typealias ActionType = HomeAction
    public typealias StateType = HomeState
    
    public init() {
    }

    public func handle(action: HomeAction, state: HomeState, completion: @escaping (HomeState) -> ()) -> HomeState {
        var newState = state
        
        newState.movies = (0...10).map {
            return HomeState.MovieState(id: $0,
                                        title: "test \($0)")
        }
        
        switch action {
        case HomeRoutingAction.start,
             HomeUIAction.didViewAppear:
            newState.currentController = .main
            
        case HomeRoutingAction.stop:
            newState.currentController = .none
            
        case HomeUIAction.didTapOnMovieCell(let id, let title):
            newState.currentController = .movieCard(id: id, title: title)
            
            
        default: break
        }
        
        
        return newState
    }
}
