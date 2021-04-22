//
//  SourceInteractor.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import Alamofire
import Foundation

class SourceInteractor: SourceInteractorProtocol {
    weak var interactorOutput: SourceInteractorOutputProtocol?
    
    
    func fetchSourceByCategory(categoryName: String) {
        AF.request("https://newsapi.org/v2/top-headlines?category=\(categoryName.lowercased())&apiKey=67a0d39e4f304e2bb256f68e54648938").responseJSON(completionHandler: { data in
            guard let results = data.value else {
                self.interactorOutput?.completionFetchSources(articles: [])
                return
            }
            
            
            var articles: [Article] = [];
            if let root = results as? [String: Any] {
                if let arrArticle = root["articles"] as? [[String: Any]] {
                    for dict in arrArticle {
                        let article = Article();
                        article.title = dict["title"] as? String
                        article.desc = dict["description"] as? String
                        article.url = dict["url"] as? String
                        article.imageURL = dict["urlToImage"] as? String
                        article.sourceName = (dict["source"] as! [String:Any])["name"] as? String
                        
                        if(article.imageURL != nil  &&  !(article.imageURL!.hasPrefix("http"))) {
                            article.imageURL = "https:\(article.imageURL!)"
                        }
                        
                        articles.append(article);
                    }
                }
            }
            
            self.interactorOutput?.completionFetchSources(articles: articles)
        })
    }
}
