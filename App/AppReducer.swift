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

        switch envelop.action {
        case AppAction.start(let startAction):
            return handle(envelop: envelop.update(action: startAction), state: AppState(), completion: completion)

        case is HomeAction:
            newState.homeState = home.handle(envelop: envelop, state: state.homeState ?? HomeState()) { homeState in
                newState.homeState = homeState
                completion(newState)
            }

        case AppAction.stop(module: HomeRoutingAction.stop):
            newState.homeState = nil

        case is MovieCardAction:
            newState.movieCardState = movieCard.handle(envelop: envelop, state: state.movieCardState ?? MovieCardState()) { movieCardState in
                newState.movieCardState = movieCardState
                completion(newState)
            }

        case AppAction.stop(module: MovieCardRoutingAction.stop):
            newState.movieCardState = nil

        default: break
        }

        return newState
    }
}
