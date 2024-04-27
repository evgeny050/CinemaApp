//
//  MoviesListInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//  
//

import Foundation

final class MoviesListInteractor: PresenterToInteractorMoviesListProtocol {
    // MARK: Properties
    private unowned let presenter: InteractorToPresenterMoviesListProtocol
    private let kpList: KPList
    
    required init(with presenter: InteractorToPresenterMoviesListProtocol, and kpList: KPList) {
        self.presenter = presenter
        self.kpList = kpList
    }
    
    func getHeader() {
        presenter.setHeader(with: kpList.name)
    }
    
    func fetchData() {
        StorageManager.shared.fetchData(
            predicate: NSPredicate(format: "slug == %@", argumentArray: [kpList.slug])
        ) { result in
            switch result {
            case .success(let films):
                if films.isEmpty {
                    fetchFromNetwork()
                } else {
                    self.presenter.didReceiveData(with: films, and: self.kpList)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchFromNetwork() {
        NetworkingManager.shared.fetchDataFaster(
            type: MovieServerModel.self,
            parameters: [
                "limit": ["250"],
                "selectFields": [
                    "id", "name", "enName", "poster",
                    "year","genres", "countries",
                    "watchability"
                ],
                "notNullFields": ["poster.url"],
                "lists" : [kpList.slug]
            ]
        ) { result in
            switch result {
            case .success(let value):
                value.forEach { $0.store(with: self.kpList.slug) }
                self.fetchData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
