//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import Alamofire
import AlamofireImage
import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var customImage: CustomImage!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContent.layer.cornerRadius = UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad ? 9:6;
        viewContent.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - View
    func setDataArticle(article: Article, imageCache: AutoPurgingImageCache) {
        lblTitle.text = article.title;
        setImage(uurl: article.imageURL, imageCache: imageCache);
    }
    
    
    func setImage(uurl: String?, imageCache: AutoPurgingImageCache) {
        customImage.sTag = uurl;
        customImage.image = nil;
        
        if let imgURL = uurl {
            if let imageCache = imageCache.image(withIdentifier: imgURL) {
                self.customImage.image = imageCache
                return;
            }
            
            
            AF.request(imgURL).responseImage(completionHandler: { response in
                if case .success(let image) = response.result {
                    if self.customImage.sTag != nil {
                        if(self.customImage.sTag! == imgURL) {
                            self.customImage.image = image;
                            imageCache.add(image, withIdentifier: imgURL)
                        }
                    }
                }
            });
        }
    }
}
