import Beaver
import Core

public final class MovieCardPresenter: Beaver.Presenting, Beaver.ChildStoring {
    public typealias StateType = MovieCardState
    public typealias ParentStateType = AppState

    public let store: ChildStore<MovieCardState, AppState>

    public let context: Context

    public init(store: ChildStore<MovieCardState, AppState>,
                context: Context) {
        self.store = store
        self.context = context
    }
}

extension MovieCardPresenter {
    public func stateDidUpdate(oldState: MovieCardState?,
                               newState: MovieCardState,
                               completion: @escaping () -> ()) {

        switch (oldState?.currentScreen ?? .none, newState.currentScreen) {
        case (.none, .main):
            #if os(iOS)
            let movieCardController = MovieCardViewController(store: store)
            context.present(controller: movieCardController, completion: completion)
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
