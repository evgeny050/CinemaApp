//
//  Moview.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.03.2024.
//

struct Movie: Codable {
    let id: Int
    //let rating: Rating?
    //let votes: Vote?
    //let movieLength: Int
    //let type: String
    let name: String
    let enName: String?
    let poster: UrlToImage
    //let backdrop: UrlToImage
    //let description: String
    let year: Int
    let genres: [GenreOrCountryOrCinemaPlatform]
    let countries: [GenreOrCountryOrCinemaPlatform]
    //let shortDescription: String
    //let ticketsOnSale: Bool
    let watchability: Watchability?
    
    var countriesAndGenresString: String {
        return "\(convertArrayToString(from: countries)) - \(convertArrayToString(from: genres))"
    }
    
    var isOnline: Bool {
        guard let watchability = watchability else { return false }
        return !watchability.items.filter { $0.name == "Kinopoisk HD" }
            .isEmpty
    }
    
    func convertArrayToString(from array: [GenreOrCountryOrCinemaPlatform]) -> String {
        array.map { $0.name }
            .joined(separator: ", ")
    }
}

struct Rating: Codable {
    let kp: Double
    let imdb: Double
}

struct Vote: Codable {
    let kp: Int
    let imdb: Int
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
