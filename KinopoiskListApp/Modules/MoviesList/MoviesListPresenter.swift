//
//  MoviesListPresenter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//  
//

final class MoviesListPresenter: PresenterToViewMoviesListProtocol {
    // MARK: Properties
    private unowned let view: ViewToPresenterMoviesListProtocol
    var interactor: PresenterToInteractorMoviesListProtocol!
    var router: PresenterToRouterMoviesListProtocol!
    
    required init(with view: ViewToPresenterMoviesListProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchData()
    }
}

extension MoviesListPresenter: InteractorToPresenterMoviesListProtocol {
    func setHeader(with title: String) {
        view.reloadHeader(with: title)
    }
    
    func didReceiveData(with movies: [Movie], and kpList: KPList) {
        let section = SectionViewModel()
        section.categoryName = kpList.name
        movies.forEach { section.movieItems.append(CellViewModel(movie: $0))}
        view.reloadData(with: section)
    }
}
