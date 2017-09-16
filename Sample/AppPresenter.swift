import Beaver
import Core
import Home
import MovieCard

final class ModulesContainer {
    var home: HomePresenter?
    var movieCard: MovieCardPresenter?
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
    }
}

extension AppPresenter {
    static func bootstrap(state: AppState = AppState(),
                          middlewares: [Store<AppState>.Middleware] = [.logging]) -> (UIWindow, AppPresenter) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        let context = NavigationContext(parent: WindowContext(window: window))
        let reducer = AppReducer(home: HomeReducer(),
                                 movieCard: MovieCardReducer()).reducer
        let store = Store<AppState>(initialState: state, middlewares: middlewares, reducer: reducer)
        let presenter = AppPresenter(context: context, store: store)
        
        presenter.subscribe()        
        presenter.dispatch(AppAction.start(withFirstAction: HomeRoutingAction.start), recipients: .emitter)
        
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
        
        switch (oldState?.movieCardState, newState.movieCardState) {
        case (.none, .some):
            let childStore = ChildStore(store: store) { $0.movieCardState }
            modules.movieCard = MovieCardPresenter(store: childStore, context: context)
            modules.movieCard?.subscribe()
            
        case (.some, .none):
            modules.movieCard?.unsubscribe()
            modules.movieCard = nil
            
        default: break
        }
        
        completion()
    }
}
