//
//  KPListsContract.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//

import Foundation

/// ViewInputProtocol (VC conforms, Presenter contains)
protocol KPListsViewInputProtocol: AnyObject {
    func reloadData(section: SectionViewModel)
}

/// ViewOutputProtocol (Presenter conforms, VC contains)
protocol KPListsViewOutputProtocol: AnyObject {
    init(with view: KPListsViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

/// InteractorInputProtocol (Interactor confroms, Presenter contains)
protocol KPListsInteractorInputProtocol: AnyObject {
    init(presenter: KPListsInteractorOutputProtocol, and category: String)
    func fetchData()
}

/// InteractorOutputProtocol (Presenter conforms, Interactor contains)
protocol KPListsInteractorOutputProtocol: AnyObject {
    func didReceiveData(with kpLists: [KPList], and category: String)
}

/// RouterInputProtocol (Router conforms, Presenter contains)
protocol KPListsRouterProtocol: AnyObject {
    init(with view: KPListsViewController)
    func routeToMoviesListVC(of kpList: KPList)
}
