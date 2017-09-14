import Beaver
import Core
import API

public final class HomePresenter: Presenting, ChildStoring {
    public typealias StateType = HomeState
    public typealias ParentStateType = AppState
    
    public var store: ChildStore<HomeState, AppState>
    public let context: Context
    
    public init(store: ChildStore<HomeState, AppState>,
                context: Context) {
        self.store = store
        self.context = context
        
        subscribe()
    }
}

// MARK: - Subscribing

extension HomePresenter {
    public func stateDidUpdate(oldState: HomeState?, newState: HomeState, completion: @escaping () -> ()) {
        switch (oldState?.currentStage ?? .none, newState.currentStage) {
        case (.none, .main):
            context.present(controller: HomeViewController(store: store), completion: completion)
        default:
            fatalError("Impossible state update")
        }
        
        completion()
    }
}

