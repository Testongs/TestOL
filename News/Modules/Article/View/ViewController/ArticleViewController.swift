//
//  ArticleViewController.swift
//  News
//
//  Created by Andre on 22/04/21.
//
import AlamofireImage
import SafariServices
import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var viewContentSearch: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    var presenter: ArticlePresenterProtocol!
    let imageCache = AutoPurgingImageCache()
    var totalRow = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.onViewDidLoad()
        viewContentSearch.layer.cornerRadius = 10;
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    deinit {
        imageCache.removeAllImages()
    }
    
    
    //MARK: - IBAction
    @objc func refresh(sender: UIRefreshControl) {
        presenter.onReload()
        refreshControl.endRefreshing()
    }
}


//MARK: - UITextField
extension ArticleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let stringValue = textFieldText.replacingCharacters(in: range, with: string)
        
        presenter.filterArticle(word: stringValue)
        return true;
    }
}


//MARK: - ArticleViewProtocol
extension ArticleViewController: ArticleViewProtocol {
    func displaySafariWithURL(url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariController = SFSafariViewController(url: url, configuration: config)
        present(safariController, animated: true, completion: nil)
    }
    
    func setNavTitle(title: String) {
        self.title = title;
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    func showProgressDialog() {
        indicator.startAnimating()
    }
    
    func hideProgressDialog() {
        indicator.stopAnimating();
    }
}


//MARK: - UITableView
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.filterArticle?.count ?? 0 > 0 {
            return totalRow;
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == totalRow-1 {
            DispatchQueue.main.async {
                self.totalRow += 20;
                tableView.reloadData();
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
        let article = presenter.filterArticle![indexPath.row % (presenter.filterArticle?.count ?? 0)];

        cell.setDataArticle(article: article, imageCache: imageCache)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        presenter.onArticleSelected(index: indexPath.row % (presenter.filterArticle?.count ?? 0))
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad ? 270:180;
    }
}
