import Beaver
import Core

#if os(iOS)

final class MovieCardViewController: Beaver.ViewController<MovieCardState, AppState, MovieCardUIAction> {

    deinit {
        dispatch(action: .finish)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let label = UILabel(frame: view.bounds)
        label.textAlignment = .center
        label.text = state.title

        view.addSubview(label)
    }
    
    override func stateDidUpdate(oldState: MovieCardState?,
                                 newState: MovieCardState,
                                 completion: @escaping () -> ()) {

        // Update the UI here

        completion()
    }
}

#endif
