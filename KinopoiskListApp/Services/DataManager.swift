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
    private let storageManager = StorageManager.shared
    
    func getCategories() -> [String] {
        return [
            "Фильмы",
            "Онлайн-кинотеатр",
            "Сериалы",
            "Сборы",
            "Премии"
        ]
    }
    
    func setFavoriteStatus(for movie: MovieServerModel?, with status: Bool, completion: (Film) -> Void) {
        guard let movie = movie else { return }
        userDefaults.set(status, forKey: "\(movie.id)/fav")
        if status {
            let film = storageManager.create(movie)
            completion(film)
            //movie.store()
        } else {
            guard let film = storageManager.deleteFilmById(by: Int64(movie.id)) else { return }
            completion(film)
        }
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
    
    func getFavoriteMovies() -> [MovieServerModel]? {
        userDefaults.array(forKey: "favoriteMovies")?.compactMap { data in
            guard let data = data as? Data else { return nil }
            return try? JSONDecoder().decode(MovieServerModel.self, from: data)
        }
    }
    
}
