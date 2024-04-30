//
//  MoviesListConfigurator.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//

protocol MoviesListConfiguratorProtocol {
    static func configure(withView view: MoviesListViewController, and kpList: KPList)
}

final class MoviesListConfigurator: MoviesListConfiguratorProtocol {
    static func configure(withView view: MoviesListViewController, and kpList: KPList) {
        let presenter = MoviesListPresenter(with: view)
        let interactor = MoviesListInteractor(with: presenter, and: kpList)
        let router = MoviesListRouter(with: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
