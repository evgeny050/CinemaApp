//
//  HomeInfoCellViewModel.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 16.04.2024.
//

import Foundation

protocol CellViewModelProtocol: AnyObject {
    var cellItemName: String { get }
    var imageUrl: String { get }
    var id: Int { get }
    var favoriteStatus: Bool { get }
    var watchedStatus: Bool { get }
    func setFavoriteStatus()
    func setWatchedStatus()
}

protocol SectionViewModelProtocol: AnyObject {
    var personItems: [CellViewModelProtocol] { get }
    var kpListItems: [CellViewModelProtocol] { get }
    var categoryItems: [CellViewModelProtocol] { get }
    var movieItems: [CellViewModelProtocol] { get set }
    var singlePerson: CellViewModelProtocol { get }
    var numberOfCategoryItems: Int { get }
    var numberOfPersonItems: Int { get }
    var numberOfKPListItems: Int { get }
    var numberOfMovieItems: Int { get }
}

final class CellViewModel: CellViewModelProtocol {
    var favoriteStatus: Bool {
        film?.isFavorite ?? false
    }
    
    var watchedStatus: Bool {
        film?.isWatched ?? false
    }
    
    func setFavoriteStatus() {
        UserDefaults.standard.set(true, forKey: "wasAnyStatusChanged")
        guard let film = film else { return }
        film.isFavorite.toggle()
        StorageManager.shared.saveContext()
    }
    
    func setWatchedStatus() {
        guard let film = film else { return }
        film.isWatched.toggle()
        StorageManager.shared.saveContext()
    }
    
    var id: Int {
        if let person = person {
            return person.id
        } else if let movie = movie {
            return Int(movie.id)
        }
        return 0
    }
    
    var cellItemName: String {
        if let person = person {
            return person.name
        } else if let kpList = kpList {
            return kpList.name
        } else if let movie = movie {
            return movie.name
        } else if let film = film {
            return film.name ?? ""
        }
        return category ?? ""
    }
    
    var imageUrl: String {
        if let movie = movie {
            return movie.poster.url
        } else if let person = person {
            return person.photo
        } else if let kpList = kpList {
            return kpList.cover.url
        } else if let film = film {
            return film.poster ?? ""
        }
        
        return ""
    }
    
    var person: Person?
    
    var kpList: KPList?
        
    private var category: String?
    
    var movie: MovieServerModel?
    
    var film: Film?
    
    var isFact: Bool
    
    init(
        kpList: KPList? = nil,
        person: Person? = nil,
        category: String? = nil,
        movie: MovieServerModel? = nil,
        film: Film? = nil,
        isFact: Bool = false
    ) {
        self.kpList = kpList
        self.person = person
        self.category = category
        self.movie = movie
        self.film = film
        self.isFact = isFact
    }
}

final class SectionViewModel: SectionViewModelProtocol {
    var personItems: [CellViewModelProtocol] = []
    var kpListItems: [CellViewModelProtocol] = []
    var categoryItems: [CellViewModelProtocol] = []
    var movieItems: [CellViewModelProtocol] = []
    var singlePerson: CellViewModelProtocol = CellViewModel()
    
    var numberOfCategoryItems: Int {
        categoryItems.count
    }
    
    var numberOfPersonItems: Int {
        personItems.count
    }
    
    var numberOfKPListItems: Int {
        kpListItems.count
    }
    
    var numberOfMovieItems: Int {
        movieItems.count
    }
    
    var categoryName = ""
}
