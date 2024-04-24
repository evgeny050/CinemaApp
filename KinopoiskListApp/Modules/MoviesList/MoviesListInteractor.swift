//
//  MoviesListInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//  
//

final class MoviesListInteractor: PresenterToInteractorMoviesListProtocol {
    // MARK: Properties
    private unowned let presenter: InteractorToPresenterMoviesListProtocol
    private let kpList: KPList
    
    required init(with presenter: InteractorToPresenterMoviesListProtocol, and kpList: KPList) {
        self.presenter = presenter
        self.kpList = kpList
    }
    
    func fetchData() {
        presenter.setHeader(with: kpList.name)
        NetworkingManager.shared.fetchDataFaster(
            type: KPMovieSection.self,
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
            
        ) { [weak self] result in
            switch result {
            case .success(let value):
                guard let self = self else { return }
                self.presenter.didReceiveData(with: value.docs, and: kpList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
