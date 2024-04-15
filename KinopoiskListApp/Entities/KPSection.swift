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
        
        if let persons = try? values.decode([Person].self, forKey: .items) {
            self.items = KPItems(persons: persons)
            return
        }
        
        if let movies = try? values.decode([Movie].self, forKey: .items) {
            self.items = KPItems(movies: movies)
            return
        }
        if let kpLists = try? values.decode([KPList].self, forKey: .items) {
            self.items = KPItems(kpLists: kpLists)
            return 
        }
//        do {
//            let kpLists = try values.decode([KPList].self, forKey: .items)
//            self.items = KPItems(kpLists: kpLists)
//            return
//        } catch(let error) {
//            print(error)
//        }
        
        throw CodingError.decoding("Decoding Error")
    }
}

struct KPItems: Decodable {
    let kpLists: [KPList]?
    let movies: [Movie]?
    let persons: [Person]?
    
    init(kpLists: [KPList]? = nil, movies: [Movie]? = nil,
         persons: [Person]? = nil) {
        self.kpLists = kpLists
        self.movies = movies
        self.persons = persons
    }
}

protocol SectionType: Decodable {
    associatedtype T: Decodable
    
    var docs: [T] { get }
}

struct KPListSection: SectionType {
    let docs: [KPList]
}

struct KPPersonSection: SectionType {
    let docs: [Person]
}

struct KPMovieSection: SectionType {
    let docs: [Movie]
}

