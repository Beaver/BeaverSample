import Beaver
import Core

public final class HomePresenter: Beaver.Presenting, Beaver.ChildStoring {
    public typealias StateType = HomeState
    public typealias ParentStateType = AppState

    public let store: ChildStore<HomeState, AppState>

    public let context: Context

    public init(store: ChildStore<HomeState, AppState>,
                context: Context) {
        self.store = store
        self.context = context
    }
}

extension HomePresenter {
    public func stateDidUpdate(oldState: HomeState?,
                               newState: HomeState,
                               completion: @escaping () -> ()) {

        switch (oldState?.currentScreen ?? .none, newState.currentScreen) {
        case (.none, .main):
            #if os(iOS)
            let homeController = HomeViewController(store: store)
            context.present(controller: homeController, completion: completion)
            #endif

        case (.main, .none):
            #if os(iOS)
            context.dismiss(completion: completion)
            #endif

        default:
            completion()
        }
    }
}
