import Alamofire
import PromiseKit

public struct Request<Resource> {
    public var path: String
    public var method: Alamofire.HTTPMethod
    public var parameters: [String: Any]?
    public var encoding: ParameterEncoding
    public var headers: [String: String]?
    public var parser: Parser<Any, Resource>

    public init(path: String,
                method: Alamofire.HTTPMethod,
                parameters: [String: Any]? = nil,
                encoding: ParameterEncoding = URLEncoding.queryString,
                headers: [String: String]? = nil,
                parser: @escaping Parser<Any, Resource>) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.parser = parser
    }
}

extension Request {
    public func toPromise<ClientType: Client>(using client: ClientType) -> Promise<Resource> {
        return client.promise(for: self)
    }
}
