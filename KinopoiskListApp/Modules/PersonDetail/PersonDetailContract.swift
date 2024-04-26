//
//  PersonDetailContract.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 17.04.2024.
//  
//

/// ViewInputProtocol (VC conforms, Presenter contains)
protocol ViewToPresenterPersonDetailProtocol: AnyObject {
    func reloadData(with section: SectionViewModel)
}

/// ViewOutputProtocol (Presenter conforms, VC contains
protocol PresenterToViewPersonDetailProtocol: AnyObject {
    init(with view: ViewToPresenterPersonDetailProtocol)
    var interactor: PresenterToInteractorPersonDetailProtocol! { get set }
    var router: PresenterToRouterPersonDetailProtocol! { get set }
    func viewDidLoad()
}

/// InteractorInput (Interactor conforms, Presenter contains)
protocol PresenterToInteractorPersonDetailProtocol: AnyObject {
    init(with presenter: InteractorToPresenterPersonDetailProtocol, and person: Person)
    func fetchData()
}

/// InteractorOutput (Presenter confroms, Interactor contains)
protocol InteractorToPresenterPersonDetailProtocol: AnyObject {
    func didReceiveData(with movies: [MovieServerModel], and person: Person)
}


/// RouterInput (Router conforms, Presenter contains)
protocol PresenterToRouterPersonDetailProtocol: AnyObject {
    
}
