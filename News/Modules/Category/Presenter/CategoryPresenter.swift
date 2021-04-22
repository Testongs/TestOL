//
//  CategoryPresenter.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import Foundation

class CategoryPresenter: CategoryPresenterProtocol {
    var categories: [String]?
    var filterCategories: [String]?
    weak var view: CategoryViewProtocol?
    var router: CategoryRouteProtocol?
    
    //Mark: - CategoryPresenterProtocol
    func onViewDidLoad() {
        router = CategoryRouter(vc: view as! CategoryViewController)
        
        categories = ["Business", "Finances", "Food", "Politics", "Sports", "Covid-19"];
        filterCategories = categories;
    }
    
    func filterCategory(word: String) {
        if categories != nil {
            if word.count > 0 {
                filterCategories = categories!.filter { ($0.lowercased().contains(word.lowercased())) }
            }
            else {
                filterCategories = categories;
            }
            view?.updateData()
        }
    }
        
    func onSelectCategoryName(catName: String) {
        router?.navigateToSubCategory(category: catName)
    }
}
