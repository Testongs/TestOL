//
//  CategoryCollectionViewCell.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var customImage: CustomImage!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContent.layer.cornerRadius = UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad ? 9:6;
        viewContent.layer.masksToBounds = true;
    }
    
    
    //MARK: - View
    func setDataCategory(category: String) {
        lblCategory.text = category;
        customImage.image = UIImage(named: category)
    }
}
