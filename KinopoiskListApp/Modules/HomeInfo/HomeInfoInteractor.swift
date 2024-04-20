//
//  HomeInfoInteractor.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.04.2024.
//
import Foundation

final class HomeInfoInteractor: HomeInfoInteractorInputProtocol {
    private unowned let presenter: HomeInfoInteractorOutputProtocol

    required init(presenter: HomeInfoInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchData() {
        var dataStore = CommonDataStore()
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        let startDate = Date()
        print("GetCollections starting...")
        NetworkingManager.shared.fetchDataFaster(
            type: KPListSection.self,
            parameters: [
                "limit": ["20"],
                "notNullFields" : ["cover.url"]
            ]
        ) { result in
            switch result {
            case .success(let value):
                dataStore.kpLists = value.docs
                print("Collections fetched")
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
            print("GetCollections finishing...")
        }
        
        dispatchGroup.enter()
        print("GetPersons starting...")
        NetworkingManager.shared.fetchDataFaster(
            type: KPPersonSection.self,
            parameters: [
                "limit": ["250"],
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
                dataStore.persons = value.docs
                print("Persons fetched")
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
            print("GetPersons finishing...")
        }
        
        print("Notify starting...")
        dispatchGroup.notify(queue: .main) { [unowned self] in
            dataStore.categoryList = DataManager.shared.getCategories()
            presenter.dataDidReceive(with: dataStore)
            print(Date().timeIntervalSince(startDate))
            print("Notify finishing...")
        }
        
    }
}
