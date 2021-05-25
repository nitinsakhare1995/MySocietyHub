//
//  ForgotPasswordVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class ForgotPasswordVC: BaseViewController {

    @IBOutlet weak var tiltView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tiltView.rotate(degrees: -40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.appOrangeColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @IBAction func btnSendOTPTapped(_ sender: Any) {
        let vc = ChangePasswordVC.instantiate(from: .login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
