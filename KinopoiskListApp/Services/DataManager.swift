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
    
    private let userDefaults = UserDefaults.standard
    
    func getCategories() -> [String] {
        return [
            "Фильмы",
            "Онлайн-кинотеатр",
            "Сериалы",
            "Сборы",
            "Премии"
        ]
    }
    
    func setFavoriteStatus(for movie: Movie?, with status: Bool) {
        guard let movie = movie else { return }
        userDefaults.set(status, forKey: "\(movie.id)/fav")
        guard let data = try? JSONEncoder().encode(movie) else { return }
        guard var array = userDefaults.array(forKey: "favoriteMovies") else {
            userDefaults.set([data], forKey: "favoriteMovies")
            return
        }
        array.append(data)
        userDefaults.set(array, forKey: "favoriteMovies")
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
    
    func getFavoriteMovies() -> [Movie]? {
        userDefaults.array(forKey: "favoriteMovies")?.compactMap { data in
            guard let data = data as? Data else { return nil }
            return try? JSONDecoder().decode(Movie.self, from: data)
        }
    }
}
