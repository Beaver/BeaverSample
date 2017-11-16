import PromiseKit
import Alamofire

public struct TMDBClient: Client {
    public typealias ErrorType = APIError

    public let baseURL: String

    let token: String

    let manager: SessionManager

    public init(baseURL: String,
                token: String,
                manager: SessionManager = Alamofire.SessionManager.default) {
        self.baseURL = baseURL
        self.token = token
        self.manager = manager
    }

    public func promise<Resource>(for request: Request<Resource>) -> Promise<Resource> {
        return toAlamofireRequest(prepare(request))
                .validate()
                .responseJSON()
                .then {
                    request.parser($0)
                }
                .recover {
                    Promise(error: APIError.create($0))
                }
    }

    private func prepare<Resource>(_ request: Request<Resource>) -> Request<Resource> {
        var mutableRequest = request

        var parameters = mutableRequest.parameters ?? [:]

        parameters["format"] = "json"
        parameters["data"] = 0
        parameters["api_key"] = token

        mutableRequest.parameters = parameters

        return mutableRequest
    }

    private func toAlamofireRequest<Resource>(_ request: Request<Resource>) -> Alamofire.DataRequest {
        let url = baseURL + (request.path.hasPrefix("/") ? "" : "/") + request.path
        return manager.request(url,
                               method: request.method,
                               parameters: request.parameters,
                               encoding: request.encoding,
                               headers: request.headers)
    }
}
