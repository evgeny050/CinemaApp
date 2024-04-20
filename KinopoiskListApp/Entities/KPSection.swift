//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

protocol SectionType: Decodable {
    associatedtype T: Decodable
    var docs: [T] { get }
    static var type: String { get }
}

struct KPListSection: SectionType {
    let docs: [KPList]
    static var type = "list?"
}

struct KPPersonSection: SectionType {
    let docs: [Person]
    static var type = "person?"
}

struct KPMovieSection: SectionType {
    let docs: [Movie]
    static var type = "movie?"
}

