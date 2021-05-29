//
//  WebViewVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 29/05/21.
//

import UIKit
import WebKit
import SVProgressHUD

class WebViewVC: BaseViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        btnCancel.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .blueBorderColor()), for: .normal)
        
        guard let urlLink = self.url, let link = URL(string: urlLink) else { return }
        let request = URLRequest(url: link)
        webView.load(request)
        
    }

    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    

}
