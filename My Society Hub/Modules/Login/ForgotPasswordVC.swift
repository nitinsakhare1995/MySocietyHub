//
//  ForgotPasswordVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class ForgotPasswordVC: BaseViewController {
    
    @IBOutlet weak var tiltView: UIView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgEmail.image = #imageLiteral(resourceName: "mail").maskWithColor(color: .blueBorderColor())
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
        if validateTextFields(){
            forgotPasswordApi()
        }
    }
    
    func forgotPasswordApi(){
        guard let username = self.emailTF.text else { return }
        Remote.shared.forgotPassword(username: username) { data in
            showSnackBar(with: data?.data?.table?.first?.errorMessage ?? "", duration: .middle)
            if data?.data?.table?.first?.isValid == true {
                let vc = ChangePasswordVC.instantiate(from: .login)
                vc.username = data?.data?.table?.first?.name
                vc.enc = data?.enc
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func validateTextFields() -> Bool{
        if emailTF.text == "" {
            showSnackBar(with: LocalizedString.email, duration: .short)
            return false
        }
        if let email = emailTF.text{
            if !email.isValidEmail(){
                showSnackBar(with: LocalizedString.validEmail, duration: .short)
                return false
            }
        }
        return true
    }
    
}
