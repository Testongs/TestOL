//
//  SourceRouter.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import UIKit

class SourceRouter: SourceRouteProtocol {
    let sourceViewController: SourceViewController
    
    init(vc: SourceViewController) {
        sourceViewController = vc;
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule(category: String) -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "SourceID") as! SourceViewController
        let presenter: SourcePresenterProtocol & SourceInteractorOutputProtocol = SourcePresenter(category: category)
        let interactor: SourceInteractorProtocol = SourceInteractor()
        let router: SourceRouteProtocol = SourceRouter(vc: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.interactorOutput = presenter
        
        return view;
    }
    
    func navigateToArticle(source: String) {
        let articleViewController = ArticleRouter.createModule(source: source)
        sourceViewController.navigationController?.pushViewController(articleViewController, animated: true)
    }
}
