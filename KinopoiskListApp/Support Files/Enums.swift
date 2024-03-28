//
//  Enums.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

import UIKit

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
    case getPersonsURL = "https://api.kinopoisk.dev/v1.4/person?page=1&limit=250&selectFields=name&selectFields=photo&selectFields=birthday&selectFields=countAwards&selectFields=death&notNullFields=photo&notNullFields=birthday&notNullFields=countAwards&sortField=countAwards&sortType=-1&birthday=01.01.1950-01.01.2002"
    case getURL = "https://api.kinopoisk.dev/v1.4/person?page=1&limit=10&notNullFields=photo"
}

enum SectionKind: Int, CaseIterable {
  case first
  case second
  case third

  var itemCount: Int {
    switch self {
    case .first:
      return 2
    default:
      return 1
    }
  }

  var innerGroupHeight: NSCollectionLayoutDimension {
    switch self {
    case .first:
      return .fractionalWidth(0.90)
    default:
      return .fractionalWidth(0.45)
    }
  }

  var orthogonalBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior {
    switch self {
    case .first:
      return .continuous
    case .second:
      return .groupPaging
    case .third:
      return .groupPagingCentered
    }
  }
}
