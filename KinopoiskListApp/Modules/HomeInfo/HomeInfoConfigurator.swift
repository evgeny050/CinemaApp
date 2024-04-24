//
//  HomeInfoConfigurator.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 16.04.2024.
//

final class HomeInfoConfigurator {
    static func configure(withView view: HomeInfoViewController) {
        let presenter = HomeInfoPresenter(view: view)
        let interactor = HomeInfoInteractor(presenter: presenter)
        let router = HomeInfoRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
