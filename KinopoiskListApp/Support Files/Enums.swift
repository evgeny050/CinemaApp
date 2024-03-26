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
