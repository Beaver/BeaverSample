import Beaver
import Core
import Home

struct AppReducer: Reducing {
    typealias StateType = AppState
    
    let home: HomeReducer
    
    func handle(envelop: ActionEnvelop,
                state: AppState,
                completion: @escaping (AppState) -> ()) -> AppState {
        var newState = state
        
        switch envelop.action {
        case AppAction.start(let startAction):
            return handle(envelop: envelop.update(action: startAction), state: AppState(), completion: completion)
            
        case AppAction.stop(module: HomeRoutingAction.stop):
            newState.homeState = nil
            
        case let action as HomeAction:
            newState.homeState = home.handle(envelop: envelop, state: state.homeState ?? HomeState()) { homeState in
                newState.homeState = homeState
                completion(newState)
            }
            
        default: break
        }
        
        return newState
    }
}
