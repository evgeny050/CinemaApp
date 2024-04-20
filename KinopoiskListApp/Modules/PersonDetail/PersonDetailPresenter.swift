//
//  PersonDetailPresenter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//  
//

import Foundation

class PersonDetailPresenter: PresenterToViewPersonDetailProtocol {
    // MARK: Properties
    private unowned let view: ViewToPresenterPersonDetailProtocol
    var interactor: PresenterToInteractorPersonDetailProtocol!
    var router: PresenterToRouterPersonDetailProtocol!
    
    required init(with view: ViewToPresenterPersonDetailProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchData()
    }
}

extension PersonDetailPresenter: InteractorToPresenterPersonDetailProtocol {
    func didReceiveData(with movies: [Movie], and person: Person) {
        let section = SectionViewModel()
        section.singlePerson = CellViewModel(person: person)
        movies.forEach { section.movieItems.append(CellViewModel(movie: $0)) }
        person.facts.forEach { section.categoryItems.append(CellViewModel(category: $0.value, isFact: true))}
        view.reloadData(with: section)
    }
}
