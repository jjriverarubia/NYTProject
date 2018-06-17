//
//  FilterViewController.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit
import Alamofire

class FilterViewController: UIViewController {

    let articleSync : ArticleSync = ArticleSync()
    
    //Filter Section
    @IBOutlet var mostMailedButton: UIButton!
    @IBOutlet var mostSharedButton: UIButton!
    @IBOutlet var mostViewedButton: UIButton!

    //Social Section
    @IBOutlet var redesStackView: UIStackView!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var twitterButton: UIButton!
    
    //Recent Section
    @IBOutlet var oneDayButton: UIButton!
    @IBOutlet var sevenDaysButton: UIButton!
    @IBOutlet var thirtyDaysButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Empieza escondido porque no hay opcion selecionada
        self.hideSocialNetworks()

    }

    
    fileprivate func hideSocialNetworks() {
        redesStackView.isHidden = true
        facebookButton.isSelected = false
        twitterButton.isSelected = false
    }
    
    @IBAction func setFilterAction(_ sender: UIButton) {
        
        sender.isSelected = true
        
        switch sender {
        case mostMailedButton:
            mostSharedButton.isSelected = false
            mostViewedButton.isSelected = false
            
            //Hide Social Network
            self.hideSocialNetworks()
            
        case mostSharedButton:
            mostMailedButton.isSelected = false
            mostViewedButton.isSelected = false
            redesStackView.isHidden = false
            
        case mostViewedButton:
            mostMailedButton.isSelected = false
            mostSharedButton.isSelected = false
            
            //Hide Social Network
            self.hideSocialNetworks()

        default:
            
            //Reset All
            //En caso de error, que empiece de cero (Esto no deberia ocurrir...Evento a crahslytics para saber que ha ocurrido )
            mostMailedButton.isSelected = false
            mostSharedButton.isSelected = false
            mostViewedButton.isSelected = false
            self.hideSocialNetworks()


        }
        
    }
    
    @IBAction func setSocialNetworkAction(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    @IBAction func setRecentArticleAction(_ sender: UIButton) {
        sender.isSelected = true
        switch sender {
        case oneDayButton:
            sevenDaysButton.isSelected = false
            thirtyDaysButton.isSelected = false
            
        case sevenDaysButton:
            oneDayButton.isSelected = false
            thirtyDaysButton.isSelected = false
            
        case thirtyDaysButton:
            oneDayButton.isSelected = false
            sevenDaysButton.isSelected = false
            
        default:
            oneDayButton.isSelected = false
            sevenDaysButton.isSelected = false
            thirtyDaysButton.isSelected = false
            
        }
    }
    
    func getSelectedSocialNetworksOpstions() -> String? {
        
        var returnedString : String? = nil
        if(facebookButton.isSelected){
            returnedString = Constants.formSocialNetworkFacebook
        }
        if(twitterButton.isSelected){
            if returnedString != nil {
                returnedString = returnedString?.appending(";\(Constants.formSocialNetworkTwitter)")
            }else{
                returnedString = Constants.formSocialNetworkTwitter
            }
            
        }
        
        return returnedString
    }
    
    func getSelectedFilterOptions() -> String? {
        var returnedString : String? = nil
        
        if(mostMailedButton.isSelected){
            returnedString = Constants.formFilterMostMailed
        }else if(mostSharedButton.isSelected){
            returnedString = Constants.formFilterMostShared
        }else if(mostViewedButton.isSelected){
            returnedString = Constants.formFilterMostViewed
        }
        
        return returnedString
    }
    
    func getSelectedRecentOptions() -> String? {
        var returnedString : String? = nil
        
        if(oneDayButton.isSelected){
            returnedString = Constants.formRecentTime1
        }else if(sevenDaysButton.isSelected){
            returnedString = Constants.formRecentTime7
        }else if(thirtyDaysButton.isSelected){
            returnedString = Constants.formRecentTime30
        }
        
        return returnedString
    }
    
    
    
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        let selectedFilter : String? = self.getSelectedFilterOptions()
        let selectedSocialNetwork : String? = self.getSelectedSocialNetworksOpstions()
        let selectedRecentArticle : String? = self.getSelectedRecentOptions()
        
        
        
        if let selectedFilter = selectedFilter, let selectedRecentArticle = selectedRecentArticle {
            if (selectedFilter == Constants.formFilterMostShared && selectedSocialNetwork == nil) {
                // Alert
                self.showAlert(withTitle: "Error", withMessage: "Seleccione una red social para continuar.")
                print("No seleciono la Red Social")
                return;
            }
            
            //Instantiate ResultViewController
            let resultViewController : ResultViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.resultViewController) as! ResultViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            resultViewController.title = "Resultado"
            articleSync.getArticles(filter: selectedFilter, socialNetwork: selectedSocialNetwork, recentDays: selectedRecentArticle) { (articles) in

                if let articles = articles{
                    resultViewController.reloadTableView(articlesArray: articles)
                }else{
                    resultViewController.reloadTableView(articlesArray: [])
                }
                
                
            }
            
        }else{
            self.showAlert(withTitle: "Error", withMessage: "Seleccione un filtro de cada sección para continuar.")
        }
        
        
    }
    
    func showAlert(withTitle title:String, withMessage message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    

}
