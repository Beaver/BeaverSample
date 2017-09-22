import Beaver
import Core

public final class MovieCardPresenter: Presenting, ChildStoring {
    public typealias StateType = MovieCardState
    public typealias ParentStateType = AppState
    
    public var store: ChildStore<MovieCardState, AppState>
    public let context: Context

    // MARK: - Init
    
    public init(store: ChildStore<MovieCardState, AppState>,
                context: Context) {
        self.store = store
        self.context = context
    }
    
    deinit {
        #if DEBUG
            print("[\(self)] --- DEINIT ---")
        #endif
    }
}

// MARK: - Subscribing

extension MovieCardPresenter {
    public func stateDidUpdate(oldState: MovieCardState?,
                               newState: MovieCardState,
                               completion: @escaping () -> ()) {
        switch (oldState?.currentController ?? .none, newState.currentController) {
        case (.none, .main):
            context.present(controller: MovieCardViewController(store: store), completion: completion)
            
        default:
            fatalError("Impossible state update")
        }
    }
}

