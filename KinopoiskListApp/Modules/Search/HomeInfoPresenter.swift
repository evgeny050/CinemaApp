//
//  HomeInfoPresenter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.04.2024.
//

import Foundation

struct HomeInfoDataStore {
    let kpLists: [KPList]
    let persons: [Person]
    let categoryList: [String]
}

final class HomeInfoPresenter: HomeInfoViewOutputProtocol {
    // MARK: - Properties
    //var interactor:
    //var router:
    
    private unowned let view: HomeInfoViewInputProtocol
    private var dataStore: HomeInfoDataStore?
    
    // MARK: - Initialization
    required init(view: HomeInfoViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        <#code#>
    }
    
    func didTapCell(at indexPath: IndexPath) {
        <#code#>
    }
}

extension HomeInfoPresenter: HomeInfoInteractorOutputProtocol {
    
}
