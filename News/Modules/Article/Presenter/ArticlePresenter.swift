//
//  ArticlePresenter.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import UIKit

class ArticlePresenter: ArticlePresenterProtocol {
    var articles: [Article]?
    var filterArticle: [Article]?
    weak var view: ArticleViewProtocol?
    var router: ArticleRouteProtocol?
    var interactor: ArticleInteractorProtocol?
    let selectedSource: String
    

    init(source: String) {
        selectedSource = source;
    }
    
    func onViewDidLoad() {
        view?.showProgressDialog()
        view?.setNavTitle(title: selectedSource)
        interactor?.fetchArticleBySource(sourceName: selectedSource);
    }
    
    func onReload() {
        articles = nil;
        filterArticle = nil;
        view?.updateData();
        
        view?.showProgressDialog()
        interactor?.fetchArticleBySource(sourceName: selectedSource);
    }
    
    func onArticleSelected(index: Int) {
        let article = filterArticle![index];
        
        if article.url != nil  &&  (URL(string: article.url!) != nil) {
            view?.displaySafariWithURL(url: URL(string: article.url!)!)
        }
    }
    
    func filterArticle(word: String) {
        if articles != nil {
            if word.count > 0 {
                filterArticle = articles!.filter { ($0.title?.lowercased().contains(word.lowercased()) ?? false) }
            }
            else {
                filterArticle = articles;
            }
            view?.updateData()
        }
    }
}


extension ArticlePresenter: ArticleInteractorOutputProtocol {
    func completionFetchArticles(articles:[Article]?) {
        view?.hideProgressDialog()
        self.articles = articles;
        filterArticle = articles;
        view?.updateData()
    }
}
