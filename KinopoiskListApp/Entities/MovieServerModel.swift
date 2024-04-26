//
//  MovieServerModel.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 25.04.2024.
//

struct MovieServerModel: ResponseType {
    let id: Int
    let name: String
    let poster: UrlToImage
    let year: Int
    let genres: [GenreOrCountryOrCinemaPlatform]
    let countries: [GenreOrCountryOrCinemaPlatform]
    let watchability: Watchability?
    
    static var type = "movie?"
    static let database = StorageManager.shared
    
    var countriesAndGenresString: String {
        return "\(convertArrayToString(from: countries)) - \(convertArrayToString(from: genres))"
    }
    
    // Determine either movie is enabled to watch on KP
    var isOnline: Bool {
        guard let watchability = watchability else { return false }
        return !watchability.items.filter { $0.name == "Kinopoisk HD" }
            .isEmpty
    }
    
    func convertArrayToString(from array: [GenreOrCountryOrCinemaPlatform]) -> String {
        array.map { $0.name }
            .joined(separator: ", ")
    }
    
    // Core Data Usage
//    func store() {
//        guard let movie = MovieServerModel.database.add(Film.self) else { return }
//        movie.id = Int64(id)
//        movie.name = name
//        movie.poster = poster.url
//        MovieServerModel.database.saveContext()
//    }
}

struct UrlToImage: Codable {
    let url: String
}

struct GenreOrCountryOrCinemaPlatform: Codable {
    let name: String
}

struct Watchability: Codable {
    let items: [GenreOrCountryOrCinemaPlatform]
}
