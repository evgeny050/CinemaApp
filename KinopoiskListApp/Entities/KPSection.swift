//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//
import Foundation

struct KPSection<T: Decodable>: Decodable, Hashable where T: Hashable {
    let id: String
    let items: [T]
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case items = "docs"
        case type
        case id
    }
    
    init(items: [T] = []) {
        self.items = items
        if let T = T.self as? Movie.Type {
            type = "Popular films"
        } else {
            type = "Collections"
        }
        id = type
    }
}
