import Core
import API
import Beaver

final class HomePresenter: Presenting, ChildStoring {
    public typealias StateType = HomeState
    public typealias ParentStateType = AppState

    public var store: ChildStore<HomeState, AppState>
    public let context: Context

    let api: TMDBClient

    init(store: ChildStore<HomeState, AppState>,
         context: Context,
         api: TMDBClient) {
        self.store = store
        self.context = context
        self.api = api
    }
}

private extension HomeScene {
    func launchHome() -> SafePromise<()> {
        let script = createScript(initialState: HomeState(movies: []))
        return context.present(stage: HomeStage(script: script))
    }
}

extension HomeScene: Subscribing {
    
    func stateDidUpdate(oldState: HomeState?,
                        newState: HomeState) -> SafePromise<()> {
        
        switch (oldState?.currentStage ?? .none, newState.currentStage) {
        case(.main, .movieCard(id: let id, title: let title, imageURL: let imageURL, overview: let overview)):
            return parentRouter.emit(.movieCard(.launch(id: id, title: title, imageURL: imageURL, overview: overview)))
        default: break
        }
        
        return SafePromise(value: ())
    }
    
}

extension Router {
    public static func createHomeRouter(context: Context, api: TMDBClient, parentRouter: Router<AppRoute>) -> Router<HomeRoute> {
        return HomeScene(context: context, api: api, parentRouter: parentRouter).router
    }
}
