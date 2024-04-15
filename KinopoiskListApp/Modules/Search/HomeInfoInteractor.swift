//
//  HomeInfoInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.04.2024.
//

/// InteractorInput (Interactor conforms, Presenter contains)
protocol HomeInfoInteractorInputProtocol: AnyObject {
    init(presenter: HomeInfoInteractorOutputProtocol)
    func fetchKPLists()
    func fetchCategories() -> [String]
    func fetchPersons()
}

/// InteractorOutput (Presenter confroms, Interactor contains)
protocol HomeInfoInteractorOutputProtocol: AnyObject {
    
}

final class HomeInfoInteractor: HomeInfoInteractorInputProtocol {
    private unowned let presenter: HomeInfoInteractorOutputProtocol

    required init(presenter: HomeInfoInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchKPLists() {
        NetworkingManager.shared.fetchDataFaster(
            type: KPListSection.self,
            url: Links.kpListsUrl.rawValue,
            parameters: ["notNullFields" : ["cover.url"]]
        ) { result in
            switch result {
            case .success(let value):
                print("KPLists fetched")
            case .failure(let error):
                print(error)
            }
            print("GetKPLists finishing...")
        }
    }
    
    func fetchCategories() -> [String] {
        DataManager.shared.getCategories()
    }
    
    func fetchPersons() {
        NetworkingManager.shared.fetchDataFaster(
            type: KPPersonSection.self,
            url: Links.personsURL.rawValue,
            parameters: [
                "selectFields": [
                    "id", "name", "enName", "photo",
                    "birthday","death", "age",
                    "profession", "facts"
                ],
                "notNullFields": [
                    "birthday", "photo", "age",
                    "name", "countAwards", "facts.value"
                ],
                "sortField": ["countAwards"],
                "sortType": ["-1"]
            ]
        ) { result in
            switch result {
            case .success(let value):
                print("Persons fetched")
            case .failure(let error):
                print(error)
            }
            print("GetPersons finishing...")
        }
    }
}
