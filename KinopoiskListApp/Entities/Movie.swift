//
//  Moview.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.03.2024.
//

struct Movie: Decodable {
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
    let genres: [GenreOrCountry]
    let countries: [GenreOrCountry]
    //let shortDescription: String
    //let ticketsOnSale: Bool
    let top10: Int?
    let top250: Int?
    
    var countriesAndGenresString: String {
        return "\(convertArrayToString(from: countries)) - \(convertArrayToString(from: genres))"
    }
    
    func convertArrayToString(from array: [GenreOrCountry]) -> String {
        array.map { $0.name }
            .joined(separator: " ")
    }
}

struct Rating: Decodable {
    let kp: Double
    let imdb: Double
}

struct Vote: Decodable {
    let kp: Int
    let imdb: Int
}

struct UrlToImage: Decodable {
    let url: String
    let previewUrl: String
}

struct GenreOrCountry: Decodable {
    let name: String
}
