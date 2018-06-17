//
//  Article.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    //Si es una API de la propia aplicacion, suelo guardar los keysValue del JSON en cada modelo, para llevar control.
    
    let title   : String?
    let author  : String?
    let section : String?
    let date    : String?
    let image   : String?
    let url     : String?

    init(title:String?, author: String?, section:String?, date:String?, image:String?, url:String?) {
        self.title = title
        self.author = author
        self.section = section
        self.date = date
        self.image = image
        self.url = url
    }
}
