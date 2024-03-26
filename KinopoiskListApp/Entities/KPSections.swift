//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//
import Foundation

struct KPMoviesSection: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "docs"
    }
}

struct KPCollectionsSection: Decodable {
    let collections: [Collection]
    
    enum CodingKeys: String, CodingKey {
        case collections = "docs"
    }
}

struct KPPersonsSection: Decodable {
    let persons: [Collection]
    
    enum CodingKeys: String, CodingKey {
        case persons = "docs"
    }
}

struct Person: Decodable {
    
}

