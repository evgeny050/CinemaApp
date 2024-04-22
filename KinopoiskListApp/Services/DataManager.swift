//
//  DataManager.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 23.03.2024.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults()
    
    func getCategories() -> [String] {
        return [
            "Фильмы",
            "Онлайн-кинотеатр",
            "Сериалы",
            "Сборы",
            "Премии"
        ]
    }
    
    func setFavoriteStatus(for movieId: Int, with status: Bool) {
        userDefaults.set(status, forKey: String(movieId))
    }
    
    func getFavoriteStatus(for movieId: Int) -> Bool {
        userDefaults.bool(forKey: String(movieId))
    }
}
