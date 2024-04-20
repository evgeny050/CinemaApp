//
//  KPListsConfigurator.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//

final class KPListsConfigurator {
    static func configure(withView view: KPListsViewController, and category: String) {
        let presenter = KPListsPresenter(with: view)
        let interactor = KPListsInteractor(presenter: presenter, and: category)
        let router = KPListsRouter(with: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
