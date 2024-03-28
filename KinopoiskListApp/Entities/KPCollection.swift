//
//  MoviesCollectionList.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 21.03.2024.
//
import Foundation

struct KPCollection: Decodable {
    let category: String
    let name: String
    let slug: String
    let moviesCount: Int
    let cover: UrlToImage
    let id: String
}
