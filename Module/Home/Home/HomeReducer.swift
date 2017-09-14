import Beaver
import Core

public struct HomeReducer: ChildReducing {
    public typealias ActionType = HomeAction
    public typealias StateType = HomeState
    
    public init() {
    }

    public func handle(action: HomeAction, state: HomeState, completion: @escaping (HomeState) -> ()) -> HomeState {
        var newState = state
        
        newState.currentStage = .main
        
        return newState
    }
}
