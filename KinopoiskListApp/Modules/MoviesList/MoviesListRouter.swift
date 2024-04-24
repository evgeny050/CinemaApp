//
//  MoviesListRouter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 18.04.2024.
//  
//

final class MoviesListRouter: PresenterToRouterMoviesListProtocol {
    private unowned let view: MoviesListViewController
    
    required init(with view: MoviesListViewController) {
        self.view = view
    }
    
    func presentMovieDetail(with viewModel: CellViewModelProtocol) {
        let vc = MovieDetailViewController()
        vc.viewModel = viewModel
        vc.delegate = view
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        view.present(vc, animated: true)
    }
}
