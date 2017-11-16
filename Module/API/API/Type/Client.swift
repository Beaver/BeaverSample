import PromiseKit

public protocol Client {
    associatedtype ErrorType: Swift.Error

    var baseURL: String { get }

    func promise<Resource>(for request: Request<Resource>) -> Promise<Resource>
}
