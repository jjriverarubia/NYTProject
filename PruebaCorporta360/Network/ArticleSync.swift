//
//  ArticleSync.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleSync {

    func getArticles(filter:String?, socialNetwork:String?, recentDays:String?, completionHandler: @escaping ([Article]?) -> Void) {
        
        //Vuelvo a chequear por si mas adelante de llega llamar el metodo sin revisar los parametros
        if let filter = filter, let recentDays = recentDays {
            var urlString : String
            if let socialNetwork = socialNetwork{
                urlString = "\(Constants.urlBase)\(filter)/all-sections/\(socialNetwork)/\(recentDays).json?api-key=\(Constants.apiKey)"
            }else{
                urlString = "\(Constants.urlBase)\(filter)/all-sections/\(recentDays).json?api-key=\(Constants.apiKey)"
            }
            let url = URL(string: urlString)!
            
            Alamofire.request(url, method: .get).validate().responseJSON() { response in
                
                switch response.result {
                case .success:
                    var result = [Article]()
                    
                    if let value = response.result.value {
                        let json = JSON(value)
                        let jsonEntries = json["results"].arrayValue
                        for entry in jsonEntries {
                            let title = entry["title"].stringValue
                            let author = entry["byline"].stringValue.replacingOccurrences(of: "By ", with: "")
                            let section = entry["section"].stringValue
                            let date = entry["published_date"].stringValue
                            let url = entry["url"].stringValue
                            let image = entry["media"][0]["media-metadata"][1]["url"].stringValue
                            let article : Article = Article(title: title, author: author, section: section, date: date, image: image, url: url)
                            result.append(article)
                        }
                    }
                    completionHandler(result)
                    
                    break
                case .failure (let error):
                    print(error)
                    completionHandler(nil)
                    break
                }
                
            }
        }else{
            print("Error al obtener informacion de las variables.")
            completionHandler(nil)
        }
        
        
    }
    
}
