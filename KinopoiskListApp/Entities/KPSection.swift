//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

struct KPSection {
    let items: KPItems
}

extension KPSection: Decodable {
    private enum CodingKeys: String, CodingKey {
        case items = "docs"
    }
    
    enum CodingError: Error {
        case decoding(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let collections = try? values.decode([KPCollection].self, forKey: .items) {
            self.items = KPItems(collections: collections)
            return
        }
//        if let movies = try? values.decode([Movie].self, forKey: .items) {
//            self.items = KPItems(movies: movies)
//            return
//        }
        if let persons = try? values.decode([Person].self, forKey: .items) {
            self.items = KPItems(persons: persons)
            return
        }
        do {
            let movies = try values.decode([Movie].self, forKey: .items)
            self.items = KPItems(movies: movies)
            return
        } catch(let error) {
            print(error)
        }
        throw CodingError.decoding("Decoding Error")
    }
}

struct KPItems: Decodable {
    let collections: [KPCollection]?
    let movies: [Movie]?
    let persons: [Person]?
    
    init(collections: [KPCollection]? = nil, movies: [Movie]? = nil, persons: [Person]? = nil) {
        self.collections = collections
        self.movies = movies
        self.persons = persons
    }
}

