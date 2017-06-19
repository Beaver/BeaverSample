import PromiseKit
import Marshal

public typealias Parser<In, Out> = (In) -> Promise<Out>

extension Unmarshaling {
    static func parseJSON(_ json: Any) -> Promise<Self> {
        guard let object = json as? MarshaledObject else {
            return Promise(error: MarshalError.typeMismatch(expected: MarshaledObject.self,
                                                            actual: type(of: json)))
        }

        do {
            return Promise(value: try Self(object: object))
        } catch let error as ParsingError {
            return Promise(error: error)
        } catch let error {
            fatalError("Unhandled error: \(error)")
        }
    }
}

extension Dictionary where Value: ValueType {
    static func parseJSON(_ json: Any) -> Promise<[Key: Value]> {
        do {
            return Promise(value: try [Key: Value].value(from: json))
        } catch let error as ParsingError {
            return Promise(error: error)
        } catch let error {
            fatalError("Unhandled error: \(error)")
        }
    }
}

extension Array where Element: Unmarshaling {
    static func parseJSON(_ json: Any) -> Promise<[Element]> {
        do {
            return Promise(value: try [Element].value(from: json))
        } catch let error as ParsingError {
            return Promise(error: error)
        } catch let error {
            fatalError("Unhandled error: \(error)")
        }
    }
}

func unwrapped<Resource>(key: String, parser: @escaping Parser<Any, Resource>) -> Parser<Any, Resource> {
    return { (json: Any) -> Promise<Resource> in
        guard let wrappedJson = json as? [String: Any] else {
            return Promise(error: ParsingError.typeMismatch(expected: [String:Any].self, actual: json.self))
        }

        guard let data = wrappedJson["data"] as? [String: Any] else {
            return Promise(error: ParsingError.keyNotFound(key: "data"))
        }

        guard let resource = data[key] else {
            return Promise(error: ParsingError.keyNotFound(key: key))
        }

        return parser(resource)
    }
}

public let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()