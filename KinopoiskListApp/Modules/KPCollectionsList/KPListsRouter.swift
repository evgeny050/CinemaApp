//
//  KPListsRouter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//

final class KPListsRouter: KPListsRouterProtocol {
    private unowned let view: KPListsViewController
    
    required init(with view: KPListsViewController) {
        self.view = view
    }
    
    func routeToMoviesListVC(of kpList: KPList) {
        let vc = MoviesListViewController()
        MoviesListConfigurator.configure(withView: vc, and: kpList)
        view.navigationController?.pushViewController(vc, animated: false)
    }
}
