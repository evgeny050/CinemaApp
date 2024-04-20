//
//  PersonDetailInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//  
//

final class PersonDetailInteractor: PresenterToInteractorPersonDetailProtocol {
    // MARK: Properties
    private unowned let presenter: InteractorToPresenterPersonDetailProtocol
    private let person: Person
    
    required init(with presenter: InteractorToPresenterPersonDetailProtocol, and person: Person) {
        self.presenter = presenter
        self.person = person
    }
    
    func fetchData() {
        NetworkingManager.shared.fetchDataFaster(
            type: KPMovieSection.self,
            parameters: [
                "limit": ["20"],
                "notNullFields": ["name", "poster.url"],
                "persons.id" : ["\(person.id)"]
            ]
        ) { [unowned self] result in
            switch result {
            case .success(let value):
                presenter.didReceiveData(with: value.docs, and: person)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
