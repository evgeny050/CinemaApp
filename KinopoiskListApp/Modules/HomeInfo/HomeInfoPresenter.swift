//
//  HomeInfoPresenter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.04.2024.
//

import Foundation

struct CommonDataStore {
    var kpLists: [KPList] = []
    var persons: [Person] = []
    var categoryList: [String] = []
    
    func getBirthdayPersons() -> [Person] {
        let personBirthdayList = persons.filter({ person in
            person.birthdayInFormat == Date().formatString() && person.death == nil
        })
        return personBirthdayList//.shuffled() //Array(personBirthdayList.prefix(10))
    }
}

final class HomeInfoPresenter {
    // MARK: - Properties
    var interactor: HomeInfoInteractorInputProtocol!
    var router: HomeInfoRouterInputProtocol!
    private unowned let view: HomeInfoViewInputProtocol
    private var dataStore: CommonDataStore?
    
    // MARK: - Initialization
    required init(view: HomeInfoViewInputProtocol) {
        self.view = view
    }
}

// MARK: - HomeInfoViewOutputProtocol
extension HomeInfoPresenter: HomeInfoViewOutputProtocol {
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let kpList = dataStore?.kpLists[indexPath.item] else { return }
            router.routeToMoviesListVC(of: kpList)
        case 1:
            guard let category = dataStore?.categoryList[indexPath.item] else { return }
            router.routeToKPListsVC(of: category)
        default:
            guard let person = dataStore?.getBirthdayPersons()[indexPath.item] else { return }
            router.routeToPersonDetailVC(of: person)
        }
    }
}

// MARK: - HomeInfoInteractorOutputProtocol
extension HomeInfoPresenter: HomeInfoInteractorOutputProtocol {
    func dataDidReceive(with dataStore: CommonDataStore) {
        self.dataStore = dataStore
        let section = SectionViewModel()
        dataStore.kpLists.forEach { item in
            section.kpListItems.append(CellViewModel(kpList: item))
        }
        dataStore.categoryList.forEach { item in
            section.categoryItems.append(CellViewModel(category: item))
        }
        dataStore.getBirthdayPersons().forEach { item in
            section.personItems.append(CellViewModel(person: item))
        }
        view.reloadData(section: section)
    }
}
