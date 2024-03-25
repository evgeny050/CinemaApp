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
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<KPSection<T>.CodingKeys> = try decoder.container(keyedBy: KPSection<T>.CodingKeys.self)
        self.items = try container.decode([T].self, forKey: KPSection<T>.CodingKeys.items)
        self.type = T.self is KPCollection.Type ? "Collections" : "Popular films"
        self.id = type
    }
}
