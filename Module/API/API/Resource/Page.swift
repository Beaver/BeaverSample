import Marshal

public struct Page<Resource: Unmarshaling> {
    public let resources: [Resource]

    public let id: Int

    public let resourceCount: Int

    public let pageCount: Int
}

extension Page: Unmarshaling {
    public init(object: MarshaledObject) throws {
        resources = try object.value(for: "results")

        id = try object.value(for: "page")

        resourceCount = try object.value(for: "total_results")

        pageCount = try object.value(for: "total_pages")
    }
}

extension Page {
    public static func get<Resource>(at id: Int = 1, from request: Request<Page<Resource>>) -> Request<Page<Resource>> {
        var mutableParameters = request.parameters ?? [:]
        mutableParameters["page"] = id

        return Request(path: request.path,
                       method: request.method,
                       parameters: mutableParameters,
                       parser: Page<Resource>.parseJSON)
    }

    public static func get<Resource>(after page: Page<Resource>, from request: Request<Page<Resource>>) -> Request<Page<Resource>> {
        let id = page.id + 1
        return get(at: id > page.pageCount ? page.pageCount : id, from: request)
    }

    public static func get<Resource>(before page: Page<Resource>, from request: Request<Page<Resource>>) -> Request<Page<Resource>> {
        let id = page.id - 1
        return get(at: id <= 0 ? 1 : id, from: request)
    }

    public func next(from request: Request<Page<Resource>>) -> Request<Page<Resource>> {
        return Page.get(after: self, from: request)
    }

    public func previous(from request: Request<Page<Resource>>) -> Request<Page<Resource>> {
        return Page.get(before: self, from: request)
    }
}
