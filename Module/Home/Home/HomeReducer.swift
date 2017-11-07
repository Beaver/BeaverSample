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

        switch action {
        case HomeRoutingAction.start:
            newState.currentScreen = .main

        case HomeRoutingAction.stop:
            newState.currentScreen = .none

        default:
            break
        }

        return newState
    }
}
