//
//  PersonDetailRouter.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//  
//

final class PersonDetailRouter: PresenterToRouterPersonDetailProtocol {
    private unowned let view: PersonDetailViewController
    
    init(view: PersonDetailViewController) {
        self.view = view
    }
    
    func presentMovieDetail(with viewModel: CellViewModelProtocol) {
        let vc = MovieDetailViewController()
        vc.viewModel = viewModel
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        view.present(vc, animated: true)
    }
}
