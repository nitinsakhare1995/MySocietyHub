//
//  ChangePasswordVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class ChangePasswordVC: BaseViewController {

    @IBOutlet weak var tiltView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        tiltView.rotate(degrees: -45)
        
    }
    @IBAction func btnChangePasswordTapped(_ sender: UIButton) {
        setRootAsLoginScreen()
    }
    
    func setRootAsLoginScreen() {
        let loginVC = LoginVC.instantiate(from: .login)
        self.navigationController?.viewControllers = [loginVC]
        windowSceneDelegate?.window?.rootViewController = navigationController
        windowSceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
