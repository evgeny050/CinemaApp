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
