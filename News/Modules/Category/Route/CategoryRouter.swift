//
//  CategoryRouter.swift
//  News
//
//  Created by Andre on 22/04/21.
//

import Foundation
class CategoryRouter: CategoryRouteProtocol {
    let viewController: CategoryViewController!
    
    init(vc: CategoryViewController) {
        viewController = vc
    }
    
    func navigateToSubCategory(category: String) {
        let sourceViewController = SourceRouter.createModule(category: category)
        viewController.navigationController?.pushViewController(sourceViewController, animated: true)
    }
}
