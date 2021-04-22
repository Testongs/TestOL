//
//  SourceProtocol.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import Foundation
import UIKit

protocol SourceViewProtocol: class {
    func showProgressDialog();
    func hideProgressDialog();
    func updateData();
    func setNavTitle(title: String)
    func displaySafariWithURL(url: URL)
}

protocol SourcePresenterProtocol: class {
    var view: SourceViewProtocol? { set get }
    var router: SourceRouteProtocol? { set get }
    var interactor: SourceInteractorProtocol? { set get }
    var articles: [Article]? { set get }
    var filterArticle: [Article]? { set get }
    
    func onViewDidLoad()
    func onReload();
    func onArticleSelected(index: Int)
    func filterArticle(word: String)
}

protocol SourceRouteProtocol: class {
    static func createModule(category: String) -> UIViewController
    func navigateToArticle(source: String)
}

protocol SourceInteractorProtocol: class {
    var interactorOutput: SourceInteractorOutputProtocol? { set get }
    
    func fetchSourceByCategory(categoryName: String);
}

protocol SourceInteractorOutputProtocol: class {
    func completionFetchSources(articles:[Article]?);
}
