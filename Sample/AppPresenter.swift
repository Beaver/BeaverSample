import Beaver
import Core
import Home

final class ModulesContainer {
    var home: HomePresenter?
}

final class AppPresenter: Presenting, Storing {
    typealias StateType = AppState
    
    let store: Store<AppState>
    
    let context: Context
    
    fileprivate let modules = ModulesContainer()
    
    init(context: Context,
         store: Store<AppState>) {
        self.store = store
        self.context = context

        subscribe()
    }
}

extension AppPresenter {
    static func bootstrap(state: AppState = AppState(),
                          middlewares: [Store<AppState>.Middleware] = [.logging]) -> (UIWindow, AppPresenter) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        let context = NavigationContext(parent: WindowContext(window: window))
        let store = Store<AppState>(initialState: state, middlewares: middlewares, reducer: AppReducer(home: HomeReducer()).reducer)
        let presenter = AppPresenter(context: context, store: store)
        
        presenter.dispatch(AppAction.start(module: HomeRoutingAction.start))
        
        return (window, presenter)
    }
}

extension AppPresenter {
    func stateDidUpdate(oldState: AppState?,
                        newState: AppState,
                        completion: @escaping () -> ()) {
        
        switch (oldState?.homeState, newState.homeState) {
        case (.none, .some):
            let childStore = ChildStore(store: store) { $0.homeState }
            modules.home = HomePresenter(store: childStore, context: context)
            modules.home?.subscribe()
            
        case (.some, .none):
            modules.home?.unsubscribe()
            modules.home = nil
            
        default: break
        }
        
        completion()
    }
}
