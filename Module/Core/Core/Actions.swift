import Beaver

// MARK: - App Actions

public enum AppAction: Action {
    case start(withFirstAction: Action)
    case stop(withLastAction: Action)
}

// MARK: - Home Actions

public protocol HomeAction: Action {
}

public enum HomeRoutingAction: HomeAction {
    case start
    case stop
}

public protocol ChildReducing: Reducing {
    associatedtype ActionType
    
    func handle(action: ActionType, state: StateType, completion: @escaping (StateType) -> ()) -> StateType
}

extension ChildReducing {
    public func handle(envelop: ActionEnvelop, state: StateType, completion: @escaping (StateType) -> ()) -> StateType {
        guard let action = envelop.action as? ActionType else {
            fatalError("Inconsistant action type")
        }
        return handle(action: action, state: state, completion: completion)
    }
}
