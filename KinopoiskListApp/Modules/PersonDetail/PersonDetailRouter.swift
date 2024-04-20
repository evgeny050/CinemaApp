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
    
}
