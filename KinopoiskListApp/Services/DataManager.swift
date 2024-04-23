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
        userDefaults.set(status, forKey: "\(movieId)/fav")
    }
    
    func getFavoriteStatus(for movieId: Int) -> Bool {
        userDefaults.bool(forKey: "\(movieId)/fav")
    }
    
    func setWatchedStatus(for movieId: Int, with status: Bool) {
        userDefaults.set(status, forKey: "\(movieId)/watch")
    }
    
    func getWatchedStatus(for movieId: Int) -> Bool {
        userDefaults.bool(forKey: "\(movieId)/watch")
    }
    
//    func setFavoriteStatus(for movieId: Int, with newStatus: Bool) {
//        var statusDict = getStatusDict(by: movieId)
//        statusDict["favorite"] = newStatus
//        userDefaults.set(statusDict, forKey: "\(movieId)")
//    }
//    
//    func getFavoriteStatus(for movieId: Int) -> Bool {
//        let dicitonary = userDefaults.dictionary(forKey: "\(movieId)")
//        return dicitonary["favorite"] as? Bool
//    }
//    
//    func setWatchedStatus(for movieId: Int, with newStatus: Bool) {
//        var statusDict = getStatusDict(by: movieId)
//        statusDict["watched"] = newStatus
//        userDefaults.set(statusDict, forKey: "\(movieId)")
//    }
//    
//    func getWatchedStatus(for movieId: Int) -> Bool {
//        let dicitonary = userDefaults.dictionary(forKey: "\(movieId)")
//        return dicitonary["watched"]
//    }
//    
//    func getStatusDict(by movieId: Int) -> Dictionary<String, Any> {
//        guard var statusDict = UserDefaults.standard.dictionary(forKey: "\(movieId)") else {
//            let dictionary = ["favorite": false, "watched": false]
//            userDefaults.set(dictionary, forKey: "\(movieId)")
//            return dictionary
//        }
//        return statu
}
