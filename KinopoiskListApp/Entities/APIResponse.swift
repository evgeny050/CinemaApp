//
//  KPSection.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 22.03.2024.
//

protocol ResponseType: Decodable {
    static var type: String { get }
}

struct APIResponse<T: ResponseType>: Decodable {
    let docs: [T]
}
