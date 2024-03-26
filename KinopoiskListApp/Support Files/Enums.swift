//
//  Enums.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

enum Font: String {
    case helveticaBold = "HelveticaNeue-Bold"
}

enum NetworkingError: Error {
    case decodingError
    case invalidURL
    case noData
}

enum EnumLinks: String {
    case baseUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10"
    case getMovieByIdUrl = "https://api.kinopoisk.dev/v1.4/movie/random"
    case getCollectionsUrl = "https://api.kinopoisk.dev/v1.4/list?page=1&limit=20&notNullFields=cover.url&sortField=createdAt&sortType=-1"
}

enum KPSectionEnum {
    case items(KPItems)
}

extension KPSectionEnum: Decodable {
    private enum CodingKeys: String, CodingKey {
        case items = "docs"
    }
    
    enum CodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let collections = try? values.decode([Collection].self, forKey: .items) {
            self = .items(KPItems(collections: collections))
            return
        }
        if let movies = try? values.decode([Movie].self, forKey: .items) {
            self = .items(KPItems(movies: movies))
            return
        }
        throw CodingError.decoding("Decoding Error: \(dump(values))")
    }
    
    var kpItems: KPItems? {
        guard case let .items(value) = self else { return nil }
        return value
    }
    
    var type: String {
        guard case let .items(value) = self else { return "" }
        return value.collections == nil ? "Советуем посмотреть" : "Популярные фильмы"
    }
}

struct KPItems: Decodable {
    let collections: [Collection]?
    let movies: [Movie]?
    
    init(collections: [Collection]? = nil, movies: [Movie]? = nil) {
        self.collections = collections
        self.movies = movies
    }
}
