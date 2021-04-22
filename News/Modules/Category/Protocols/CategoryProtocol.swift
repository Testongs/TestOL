//
//  CategoryProtocol.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import Foundation

protocol CategoryViewProtocol: class {
    func updateData();
}

protocol CategoryRouteProtocol: class {
    func navigateToSubCategory(category: String);
}

protocol CategoryPresenterProtocol: class {
    var view: CategoryViewProtocol? { set get }
    var router: CategoryRouteProtocol? { set get }
    var filterCategories: [String]? { set get }
    var categories: [String]? { set get }
    
    func onViewDidLoad();
    func filterCategory(word: String)
    func onSelectCategoryName(catName: String)
}

protocol CategoryInteractorProtocol:class {
    var interactorOutput: CategoryInteractorOutputProtocol? { set get }
    
    func fetchCategories();
}

protocol CategoryInteractorOutputProtocol: class {
    func CompletionFetchCategory(results: [Category]?)
}
