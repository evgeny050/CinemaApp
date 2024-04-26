//
//  SearchContract.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.04.2024.
//
import Foundation

/// ViewInputProtocol (VC conforms, Presenter contains)
protocol HomeInfoViewInputProtocol: AnyObject {
    func reloadData(section: SectionViewModel, forAllSections: Bool)
}

/// ViewOutputProtocol (Presenter conforms, VC contains
protocol HomeInfoViewOutputProtocol: AnyObject {
    init(view: HomeInfoViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
    func updateFavoriteMovies()
}

/// InteractorInput (Interactor conforms, Presenter contains)
protocol HomeInfoInteractorInputProtocol: AnyObject {
    init(presenter: HomeInfoInteractorOutputProtocol)
    func fetchData()
    func getFavorites()
}

/// InteractorOutput (Presenter confroms, Interactor contains)
protocol HomeInfoInteractorOutputProtocol: AnyObject {
    func dataDidReceive(with dataStore: CommonDataStore)
    func favoritesDidUpdate(with movies: [Film])
}

/// RouterInput (Router conforms, Presenter contains)
protocol HomeInfoRouterInputProtocol {
    init(view: HomeInfoViewController)
    func routeToMoviesListVC(of kpList: KPList)
    func routeToKPListsVC(of category: String)
    func routeToPersonDetailVC(of person: Person)
    func presentMovieDetail(with viewModel: CellViewModelProtocol)
}
