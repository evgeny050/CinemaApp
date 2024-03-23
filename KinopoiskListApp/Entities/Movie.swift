//
//  Moview.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.03.2024.
//

struct Movie: Decodable, Hashable {
    let rating: Rating?
    let votes: Vote?
    let backdrop: UrlToImage
    let movieLength: Int
    let id: Int
    let type: String
    let name: String
    let poster: UrlToImage
    let description: String
    let year: Int
    let genres: [GenreOrCountry]
    let shortDescription: String
    let ticketsOnSale: Bool
    let top10: Int?
    let top250: Int?
    
//    init(moviesData: [String: Any]) {
//        rating = moviesData["source"] as? Rating
//        votes = moviesData["votes"] as? Vote
//        backdrop = moviesData["backdrop"] as? Backdrop
//        movieLength = moviesData["movieLength"] as? Int ?? 0
//        id = moviesData["id"] as? Int ?? 0
//        type = moviesData["type"] as? String ?? ""
//        name = moviesData["name"] as? String ?? ""
//        description = moviesData["description"] as? String ?? ""
//        year = moviesData["year"] as? Int ?? 0
//        genres = moviesData["genres"] as? [GenreOrCountry] ?? []
//        shortDescription = moviesData["shortDescription"] as? String ?? ""
//        ticketsOnSale = moviesData["ticketsOnSale"] as? Bool ?? false
//        logo = moviesData["logo"] as? Logo
//        top10 = moviesData["top10"] as? Int
//        top250 = moviesData["top250"] as? Int
//    }
//    
//    static func getMovies(from value: Any) -> [Movie] {
//        guard let moviesData = value as? [String: Any] else {
//            return []
//        }
//        
//        guard let moviesList = moviesData["docs"] as? [[String: Any]] else {
//            return []
//        }
//        
//        return moviesList.map { Movie(moviesData: $0) }
//    }
}

struct Rating: Decodable, Hashable {
    let kp: Double
    let imdb: Double
}

struct Vote: Decodable, Hashable {
    let kp: Int
    let imdb: Int
}

struct UrlToImage: Decodable, Hashable {
    let url: String
    let previewUrl: String
}

struct GenreOrCountry: Decodable, Hashable {
    let name: String
}
