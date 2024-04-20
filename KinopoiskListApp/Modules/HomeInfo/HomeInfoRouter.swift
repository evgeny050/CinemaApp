//
//  HomeInfoRouter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 16.04.2024.
//

class HomeInfoRouter: HomeInfoRouterInputProtocol {
    private unowned let view: HomeInfoViewController
    
    required init(view: HomeInfoViewController) {
        self.view = view
    }
    
    func routeToMoviesListVC(of kpList: KPList) {
        let vc = MoviesListViewController()
        MoviesListConfigurator.configure(withView: vc, and: kpList)
        view.navigationController?.pushViewController(vc, animated: false)
    }
    
    func routeToKPListsVC(of category: String) {
        let vc = KPListsViewController()
        KPListsConfigurator.configure(withView: vc, and: category)
        view.navigationController?.pushViewController(vc, animated: false)
    }
    
    func routeToPersonDetailVC(of person: Person) {
        let vc = PersonDetailViewController()
        PersonDetailConfigurator.configure(withView: vc, and: person)
        view.navigationController?.pushViewController(vc, animated: false)
    }
}
