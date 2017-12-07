import Beaver
import Core

public struct HomeReducer: Beaver.ChildReducing {
    public typealias ActionType = HomeAction
    public typealias StateType = HomeState

    public init() {
    }

    public func handle(action: HomeAction,
                       state: HomeState,
                       completion: @escaping (HomeState) -> ()) -> HomeState {
        var newState = state
        
        newState.movies = (0...10).map {
            return HomeState.MovieState(id: $0,
                                        title: "test \($0)")
        }
        
        switch ExhaustiveAction<HomeRoutingAction, HomeUIAction>(action) {
        case .routing(.start),
             .ui(.didViewAppear):
            newState.currentScreen = .main
            
        case .routing(.stop),
             .ui(.finish):
            newState.currentScreen = .none
            
        case .ui(.didTapOnMovieCell(let id, let title)):
            newState.currentScreen = .movieCard(id: id, title: title)

        case .ui(.didLoadView),
             .ui(.didPullToRefresh),
             .ui(.didScrollToBottom):
            break
        }
        
        return newState
    }
}
