//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//
import Foundation

struct KPMoviesSection: Decodable, Hashable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "docs"
    }
}

struct KPCollectionsSection: Decodable, Hashable {
    let collections: [KPCollection]
    
    enum CodingKeys: String, CodingKey {
        case collections = "docs"
    }
}
