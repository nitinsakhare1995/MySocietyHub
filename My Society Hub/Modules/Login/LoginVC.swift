//
//  LoginVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var tiltView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tiltView.rotate(degrees: -45)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let forgotPasswordVC = ForgotPasswordVC.instantiate(from: .login)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        setRootAsDashboardScreen()
    }
    
    func setRootAsDashboardScreen() {
        let vc = UIStoryboard(name: Storyboard.dashboard.rawValue, bundle: nil).instantiateViewController(identifier: "DashboardTabBarVC") as! DashboardTabBarVC
        self.navigationController?.viewControllers = [vc]
        windowSceneDelegate?.window?.rootViewController = navigationController
        windowSceneDelegate?.window?.makeKeyAndVisible()
    }
    
}


