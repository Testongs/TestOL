//
//  ArticleRouter.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import UIKit

class ArticleRouter: ArticleRouteProtocol {
    let articleViewController: ArticleViewController
    
    init(vc: ArticleViewController) {
        articleViewController = vc;
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule(source: String) -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ArticleID") as! ArticleViewController
        let presenter: ArticlePresenterProtocol & ArticleInteractorOutputProtocol = ArticlePresenter(source: source)
        let interactor: ArticleInteractorProtocol = ArticleInteractor()
        let router: ArticleRouteProtocol = ArticleRouter(vc: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.interactorOutput = presenter
        
        return view;
    }
}
