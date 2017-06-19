import Marshal
import Core

public struct Genre {
    public let id: Int
    public let name: String
}

extension Genre: Unmarshaling {
    public init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        name = try object.value(for: "name")
    }
}
