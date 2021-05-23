//
//  LoginVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var tiltView: UIView!
    @IBOutlet weak var lblAppName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributeText()
//        tiltView.rotate(degrees: -45)
        
    }
    
    func setAttributeText(){
        let appName = NSMutableAttributedString.init(string: LocalizedString.appName)
        appName.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32),
                                      NSAttributedString.Key.foregroundColor: UIColor.black],
                                     range: NSMakeRange(0, 2))
        lblAppName.attributedText = appName

    }
    

    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let forgotPasswordVC = NewComplaintVC.instantiate(from: .noticeComplaint)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        
//        let vc = UIStoryboard(name: Storyboard.dashboard.rawValue, bundle: nil).instantiateViewController(identifier: "DashboardTabBarVC") as! DashboardTabBarVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


