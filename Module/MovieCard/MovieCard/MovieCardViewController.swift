import Beaver
import Core

final class MovieCardViewController: ViewController<MovieCardState, AppState> {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = state.movie?.title
    }
    
    deinit {
        dispatch(action: AppAction.stop(withLastAction: MovieCardRoutingAction.stop))
    }
    
    // MARK: - Subscribing
    
    override func stateDidUpdate(oldState: MovieCardState?,
                                 newState: MovieCardState,
                                 completion: @escaping () -> ()) {
        completion()
    }
}
