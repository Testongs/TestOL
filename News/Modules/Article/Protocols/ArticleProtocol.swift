//
//  ArticleProtocol.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import Foundation
import UIKit

protocol ArticleViewProtocol: class {
    func showProgressDialog();
    func hideProgressDialog();
    func updateData();
    func setNavTitle(title: String)
    func displaySafariWithURL(url: URL)
}

protocol ArticlePresenterProtocol: class {
    var view: ArticleViewProtocol? { set get }
    var router: ArticleRouteProtocol? { set get }
    var interactor: ArticleInteractorProtocol? { set get }
    var articles: [Article]? { set get }
    var filterArticle: [Article]? { set get }
    
    func onViewDidLoad()
    func onReload();
    func onArticleSelected(index: Int)
    func filterArticle(word: String)
}

protocol ArticleRouteProtocol: class {
    static func createModule(source: String) -> UIViewController
}

protocol ArticleInteractorProtocol: class {
    var interactorOutput: ArticleInteractorOutputProtocol? { set get }
    
    func fetchArticleBySource(sourceName: String);
}

protocol ArticleInteractorOutputProtocol: class {
    func completionFetchArticles(articles:[Article]?);
}
