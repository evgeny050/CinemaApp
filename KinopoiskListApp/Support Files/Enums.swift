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
    
    case kpListsUrl = "https://api.kinopoisk.dev/v1.4/list?page=1&limit=20&notNullFields=cover.url&sortField=updatedAt&sortType=-1"
    
    case personsURL = "https://api.kinopoisk.dev/v1.4/person?page=1&limit=250"
    
    case moviesByPersonUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=20"
    
    case moviesByKPListUrl = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=250"
    
    case kpListsByCategoryUrl = "https://api.kinopoisk.dev/v1.4/list?page=1&limit=250"
    
}

enum LinkParameters: RawRepresentable {
    typealias RawValue = Array<String>
    
    init?(rawValue: Array<String>) {
        if rawValue == ["first", "second"] {
            self = .personsNotNullFields
        }
        return nil
    }
    
    var rawValue: Array<String> {
        switch self {
        case .personsNotNullFields:
            return ["id", "name", "enName", "photo",
                    "growth", "age", "countAwards", "profession.value",
                    "facts.value", "movies.id", "birthday"]
        case .personsSelectFields:
           return ["id", "name", "enName","photo",
                   "growth", "birthday", "death", "age",
                    "countAwards","profession", "facts", "movies"]
        }
    }

    case personsNotNullFields
    case personsSelectFields
    
//    static let persons = ["selectFields": "id", "name", "enName","photo",
//                                           "growth", "birthday", "death", "age",
//                                           "countAwards","profession", "facts", "movies"],
//                          "notNullFields": ["id", "name", "enName", "photo",
//                                            "growth", "age", "countAwards", "profession.value",
//                                            "facts.value", "movies.id", "birthday"]
//                          ]
//    static let moviesByKPList = ["notNullFields": ["poster.url"]]
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
