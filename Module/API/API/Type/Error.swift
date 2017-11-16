import Marshal
import Alamofire

public typealias ParsingError = MarshalError

public enum APIError: Swift.Error {
    case http(AFError)
    case parsing(ParsingError)
    case unknown(Swift.Error)
}

extension APIError {
    public static func create(_ error: Error) -> APIError {
        switch error {
        case let error as ParsingError:
            return .parsing(error)
        case let error as AFError:
            return .http(error)
        default:
            return .unknown(error)
        }
    }

    /// If HTTP error, returns the status code
    public var statusCode: Int? {
        if case .http(.responseValidationFailed(reason:.unacceptableStatusCode(let code))) = self {
            return code
        } else {
            return nil
        }
    }
}
