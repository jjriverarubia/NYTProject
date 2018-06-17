//
//  WebResultViewController.swift
//  PruebaCorporta360
//
//  Created by Jose Rivera Rubia on 16/06/2018.
//  Copyright © 2018 Jose Rivera Rubia. All rights reserved.
//

import UIKit
import WebKit
class WebResultViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var urlStr : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlStr = urlStr {
            let urlRequest : URLRequest = URLRequest(url: URL(string: urlStr)!)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if (error == nil) {
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.webView.load(urlRequest)
                    }
                }else{
                    print("Error al cargar pagina \(String(describing: error))")
                    //alert
                    let alert = UIAlertController(title: "Error", message: "Error al carga la página \n Vuelva intentarlo más tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            }.resume()
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
