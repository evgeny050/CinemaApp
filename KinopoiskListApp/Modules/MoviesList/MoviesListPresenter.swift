//
//  MoviesListPresenter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//  
//

// MARK: - PresenterToViewMoviesListProtocol
final class MoviesListPresenter: PresenterToViewMoviesListProtocol {
    // MARK: Properties
    private unowned let view: ViewToPresenterMoviesListProtocol
    var interactor: PresenterToInteractorMoviesListProtocol!
    var router: PresenterToRouterMoviesListProtocol!
    
    private let section = SectionViewModel()
    
    required init(with view: ViewToPresenterMoviesListProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didTapCell(at index: Int) {
        router.presentMovieDetail(with: section.movieItems[index])
    }
}

// MARK: - Extensions - InteractorToPresenterMoviesListProtocol
extension MoviesListPresenter: InteractorToPresenterMoviesListProtocol {
    func setHeader(with title: String) {
        view.reloadHeader(with: title)
    }
    
    func didReceiveData(with movies: [MovieServerModel], and kpList: KPList) {
        section.categoryName = kpList.name
         movies.forEach { section.movieItems.append(CellViewModel(movie: $0))}
        view.reloadData(with: section)
    }
}
