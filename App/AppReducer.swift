import Beaver
import Core
import Home
import MovieCard

struct AppReducer: Beaver.Reducing {
    let home: HomeReducer
    let movieCard: MovieCardReducer

    typealias StateType = AppState

    func handle(envelop: ActionEnvelop,
                state: AppState,
                completion: @escaping (AppState) -> ()) -> AppState {
        var newState = state

        if case AppAction.start(let startAction) = envelop.action {
            return handle(envelop: envelop.update(action: startAction), state: newState, completion: completion)
        }

        if envelop.action is HomeAction {
            newState.homeState = home.handle(envelop: envelop, state: state.homeState ?? HomeState()) { homeState in
                newState.homeState = homeState
                completion(newState)
            }
        }
        
        if case AppAction.stop(module: HomeRoutingAction.stop) = envelop.action {
            newState.homeState = nil
        }

        if envelop.action is MovieCardAction {
            newState.movieCardState = movieCard.handle(envelop: envelop, state: state.movieCardState ?? MovieCardState()) { movieCardState in
                newState.movieCardState = movieCardState
                completion(newState)
            }
        }
        
        if case AppAction.stop(module: MovieCardRoutingAction.stop) = envelop.action {
            newState.movieCardState = nil
        }

        return newState
    }
}
