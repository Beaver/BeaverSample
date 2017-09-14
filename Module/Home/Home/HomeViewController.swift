import Beaver
import Core

final class HomeViewController: ViewController<HomeState, AppState> {
    override func stateDidUpdate(oldState: HomeState?,
                                 newState: HomeState,
                                 completion: @escaping () -> ()) {
        
        // Update the UI here
        completion()
    }
}
