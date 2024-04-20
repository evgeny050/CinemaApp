//
//  PersonDetailConfigurator.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//

final class PersonDetailConfigurator {
    static func configure(withView view: PersonDetailViewController, and person: Person) {
        let presenter = PersonDetailPresenter(with: view)
        let interactor = PersonDetailInteractor(with: presenter, and: person)
        let router = PersonDetailRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
