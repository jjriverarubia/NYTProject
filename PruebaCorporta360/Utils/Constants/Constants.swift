//
//  Constants.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit

struct Constants {
    
    //URLConstants
    static let urlBase = "https://api.nytimes.com/svc/mostpopular/v2/"
    static let apiKey = "32534511931e4dc1b5627b6918ca0d6b"
    
    //ViewController Constants
    static let filterViewConroller = "FilterViewConroller"
    static let resultViewController = "ResultViewController"
    static let webResultViewController = "WebResultViewController"

    //FormAnswers
    
    //Filter
    static let formFilterMostMailed = "mostemailed"
    static let formFilterMostShared = "mostshared"
    static let formFilterMostViewed = "mostviewed"
    
    //Social Network
    static let formSocialNetworkFacebook = "facebook"
    static let formSocialNetworkTwitter = "twitter"
    
    //Recent Time
    static let formRecentTime1 = "1"
    static let formRecentTime7 = "7"
    static let formRecentTime30 = "30"
    /*
        Suelo crear diferentes Stuct de constantes, de tal manera que se pueda mantener el orden. Por ejemplo: Constantes de URL, constantes de View Controllers, Constantes de mensajes (Alerts), etc
     */
}
