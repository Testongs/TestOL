//
//  CategoryViewController.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import AlamofireImage
import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var viewContentSearch: UIView!
    @IBOutlet weak var collView: UICollectionView!
    
    var presenter: CategoryPresenterProtocol!
    var totalCell = 50;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 29/255.0, green: 29/255.0, blue: 29/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        viewContentSearch.layer.cornerRadius = 10;
        
        presenter = CategoryPresenter();
        presenter.view = self;
        presenter.onViewDidLoad()
    }
}


//MARK: - UITextField
extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let stringValue = textFieldText.replacingCharacters(in: range, with: string)
        
        presenter.filterCategory(word: stringValue)
        return true;
    }
}


//MARK: - UICollectionView
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        
        let count = presenter.filterCategories?.count ?? 0
        let category = presenter.filterCategories![indexPath.row % count];
        
        cell.setDataCategory(category: category)

        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let count = presenter.filterCategories?.count ?? 0
        let category = presenter.filterCategories![indexPath.row % count];
        presenter.onSelectCategoryName(catName: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.filterCategories?.count ?? 0 > 0 {
            return totalCell;
        }
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(indexPath.row == totalCell-1) {
            DispatchQueue.main.async {
                self.totalCell += 20
                self.collView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = collectionView.bounds.size.width/22.0
        
        if UIUserInterfaceIdiom.pad == UI_USER_INTERFACE_IDIOM() {
            let diameter = ((collectionView.bounds.size.width-(padding*2.0))/3.0);
            return CGSize(width: diameter, height: diameter);
        }
        
        let diameter = ((collectionView.bounds.size.width-(padding*2.0))/2.0);
        return CGSize(width: diameter, height: diameter);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = collectionView.bounds.size.width/22.0
        return UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}



//MARK: - CategoryViewProtocol
extension CategoryViewController: CategoryViewProtocol {
    func updateData() {
        collView.reloadData()
    }
}
