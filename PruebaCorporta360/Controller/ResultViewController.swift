//
//  ResultViewController.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var emptyTableViewMessageLabel: UILabel!
    var articles : [Article] = []
    let articleCellReuseIdentifier : String = "articleCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }

    fileprivate func setViewController() {
        //Muestro o no el activityIndicator.
        if(articles.count > 0){
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            
        }else{
            tableView.isHidden = true
            activityIndicator.startAnimating()
        }
    }

    func reloadTableView(articlesArray:[Article]){
        articles = articlesArray
        activityIndicator.stopAnimating()

        if(articles.count > 0){
            tableView.isHidden = false
            tableView.reloadData()
        }else{
            tableView.isHidden = true
            emptyTableViewMessageLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellReuseIdentifier, for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        
        //Setting UI
        cell.titleLabel.text = article.title ?? ""
        cell.authorLabel.text = article.author ?? ""
        cell.sectionLabel.text = article.section ?? ""
        cell.dateLabel.text = article.date ?? ""

        
        //Suelo usar KingFisher(Swift) o SdWebImage(ObjC) para descarga imagenes, ademas de agregarle un placeholder...
        if let urlStr = article.image{
            if(!urlStr.isEmpty){
                let url:URL = URL(string: urlStr)!
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url.lastPathComponent)
                    print("Imagen Descargada...")
                    DispatchQueue.main.async() {
                        cell.articleImageView.image = UIImage(data: data)
                    }
                    }.resume()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let webResultViewController : WebResultViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.webResultViewController) as! WebResultViewController
        webResultViewController.title = article.title
        webResultViewController.urlStr = article.url
        self.navigationController?.pushViewController(webResultViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    

}
