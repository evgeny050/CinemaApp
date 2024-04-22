//
//  HomeInfoCellViewModel.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 16.04.2024.
//

protocol CellViewModelProtocol: AnyObject {
    var cellItemName: String { get }
    var imageUrl: String { get }
}

protocol SectionViewModelProtocol: AnyObject {
    var personItems: [CellViewModelProtocol] { get }
    var kpListItems: [CellViewModelProtocol] { get }
    var categoryItems: [CellViewModelProtocol] { get }
    var movieItems: [CellViewModelProtocol] { get }
    var singlePerson: CellViewModelProtocol { get }
    var numberOfCategoryItems: Int { get }
    var numberOfPersonItems: Int { get }
    var numberOfKPListItems: Int { get }
    var numberOfMovieItems: Int { get }
}

final class CellViewModel: CellViewModelProtocol {
    var cellItemName: String {
        if let person = person {
            return person.name
        } else if let kpList = kpList {
            return kpList.name
        } else if let movie = movie {
            return movie.name
        }
        return category ?? ""
    }
    
    var imageUrl: String {
        if let movie = movie {
            return movie.poster.url
        }
        if let person = person {
            return person.photo
        } else if let kpList = kpList {
            return kpList.cover.url
        }
        return ""
    }
    
    var person: Person?
    
    private var kpList: KPList?
        
    private var category: String?
    
    var movie: Movie?
    
    var isFact: Bool
    
    init(
        kpList: KPList? = nil,
        person: Person? = nil,
        category: String? = nil,
        movie: Movie? = nil,
        isFact: Bool = false
    ) {
        self.kpList = kpList
        self.person = person
        self.category = category
        self.movie = movie
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
