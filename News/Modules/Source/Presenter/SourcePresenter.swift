//
//  SourcePresenter.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import UIKit

class SourcePresenter: SourcePresenterProtocol {
    var articles: [Article]?
    var filterArticle: [Article]?
    weak var view: SourceViewProtocol?
    var router: SourceRouteProtocol?
    var interactor: SourceInteractorProtocol?
    let selectedCategory: String
    

    init(category: String) {
        selectedCategory = category;
    }
    
    func onViewDidLoad() {
        view?.showProgressDialog()
        view?.setNavTitle(title: selectedCategory)
        interactor?.fetchSourceByCategory(categoryName: selectedCategory);
    }
    
    func onReload() {
        articles = nil;
        filterArticle = nil;
        view?.updateData();
        
        view?.showProgressDialog()
        interactor?.fetchSourceByCategory(categoryName: selectedCategory);
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


extension SourcePresenter: SourceInteractorOutputProtocol {
    func completionFetchSources(articles:[Article]?) {
        view?.hideProgressDialog()
        self.articles = articles;
        filterArticle = articles;
        view?.updateData()
    }
}
