//
//  DataManager.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 23.03.2024.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func getCategories() -> [String] {
        return [
            "Фильмы",
            "Онлайн-кинотеатр",
            "Сериалы",
            "Сборы",
            "Премии"
        ]
    }
}
