import Beaver

enum AppAction: Action {
    case start(module: Action)
    case stop(module: Action)
}
