//
//  Enums.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

import UIKit

enum NetworkingError: Error {
    case decodingError
    case invalidURL
    case noData
}

enum Links: String {
    case baseUrl = "https://api.kinopoisk.dev/v1.4/"
    case getMovieByPersonIdUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&persons.id=1"
    case getCollectionsUrl = "https://api.kinopoisk.dev/v1.4/list?page=1&limit=30&notNullFields=cover.url&sortField=updatedAt&sortType=-1"
    case getPersonsURL = "https://api.kinopoisk.dev/v1.4/person?page=1&limit=250&selectFields=id&selectFields=name&selectFields=enName&selectFields=photo&selectFields=growth&selectFields=birthday&selectFields=death&selectFields=age&selectFields=countAwards&selectFields=profession&selectFields=facts&selectFields=movies&notNullFields=id&notNullFields=name&notNullFields=enName&notNullFields=photo&notNullFields=growth&notNullFields=age&notNullFields=countAwards&notNullFields=profession.value&notNullFields=facts.value&notNullFields=movies.id&notNullFields=birthday"
    
    case moviesByPersonUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&persons.id=" //"https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&notNullFields=name&notNullFields=enName&notNullFields=year&notNullFields=genres&notNullFields=countries&notNullFields=poster.url&sortField=rating.kp&sortType=-1&persons.id="
    
    case moviesByCollectionUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=250&&notNullFields=poster.url&lists="
}

enum SectionKind: Int, CaseIterable {
    case collections
    case movies
    case persons
    case categories
    case facts
    
    var itemHeight: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .absolute(180)
        default:
            return .absolute(235)
        }
    }
    
    var itemWidth: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .absolute(180)
        default:
            return .absolute(235)
        }
    }

    var groupHeight: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .absolute(180)
        default:
            return .absolute(235)
        }
    }
    
    var groupWidht: NSCollectionLayoutDimension {
        switch self {
        case .collections:
            return .absolute(180)
        default:
            return .absolute(235)
        }
    }
    
    var imageHeight: Int {
        switch self {
        case .collections:
            return 125
        default:
            return 180
        }
    }
    
    var isClipped: Bool {
        self == .persons
    }
}
