//
//  StorageManager.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 24.04.2024.
//

import Foundation
import CoreData

enum FilmStatus {
    case added
    case deleted
    case none
}

final class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Film")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }

    // MARK: - CRUD
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(
            forEntityName: entityName,
            in: viewContext
        ) else {
            return nil
        }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func create(_ movie: MovieServerModel) -> Film {
        let film = Film(context: viewContext)
        film.id = Int64(movie.id)
        film.name = movie.name
        film.poster = movie.poster.url
        film.isFavorite = true
        saveContext()
        return film
    }
    
    func update(_ film: Film) {
        //let favoriteMovies = FavoriteMovies(context: viewContext)
        //film.isFavorite.toggle()
        //favoriteMovies.addToFavorites(film)
        //completion(movie)
        saveContext()
    }
    
    func fetchData(completion: (Result<[Film], Error>) -> Void) {
        let fetchRequest = Film.fetchRequest()
        //NSPredicate(format: "isFavorite == %@", argumentArray: [true])
        do {
            let movies = try viewContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func deleteFilmById(by id: Int64) -> Film? {
        let fetchRequest = Film.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        do {
            let films = try viewContext.fetch(fetchRequest)
            films.forEach { delete($0) }
            return films.first
        } catch(let error) {
            print(error)
        }
        return nil
    }
    
    func fetchFavorites() -> [Film] {
        let fetchRequest = Film.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "isFavorite = true")
        //NSPredicate(format: "isFavorite == %@", argumentArray: [true])
        do {
           let results = try viewContext.fetch(fetchRequest)
           return results
        } catch(let error) {
            print(error)
        }
        return []
    }
    
    func delete(_ movie: Film) {
        viewContext.delete(movie)
        saveContext()
    }

    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
}
