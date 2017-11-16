import Marshal
import Core

public struct Movie {
    public let id: Int
    public let title: String
    public let overview: String
    public let voteAverage: Double
    public let releaseDate: Date
    public let posterPath: String
    public let backdropPath: String
    
    public let homepage: String?
    public let voteCount: Int?
    public let genres: [Genre]?
    public let status: String?
}

extension Movie: Unmarshaling {
    public init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        title = try object.value(for: "title")
        overview = try object.value(for: "overview")
        voteAverage = try object.value(for: "vote_average")
        releaseDate = try object.value(for: "release_date")
        posterPath = try object.value(for: "poster_path")
        backdropPath = try object.value(for: "backdrop_path")
        
        // Optional - movie details
        homepage = try? object.value(for: "homepage")
        voteCount = try? object.value(for: "vote_count")
        genres = try? object.value(for: "genres")
        status = try? object.value(for: "status")
    }
}

extension Movie {
    public static func topRated() -> Request<Page<Movie>> {
        return Request(path: "movie/top_rated",
                       method: .get,
                       parameters: [:],
                       parser: Page<Movie>.parseJSON)
    }
    
    public static func getBy(id: Int) -> Request<Movie> {
        return Request(path: "movie/\(id)",
                       method: .get,
                       parameters: [:],
                       parser: Movie.parseJSON)
    }
}
