//
//  ChangePasswordVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class ChangePasswordVC: BaseViewController {
    
    @IBOutlet weak var tiltView: UIView!
    @IBOutlet weak var imgOTP: UIImageView!
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var btnShowPassword: UIButton!
    
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var showPassword = false
    
    var username: String?
    var enc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tiltView.rotate(degrees: -45)
        changeImageColors()
    }
    
    func changeImageColors(){
        btnShowPassword.setImage(#imageLiteral(resourceName: "viewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        imgOTP.image = #imageLiteral(resourceName: "mail").maskWithColor(color: .blueBorderColor())
        imgPassword.image = #imageLiteral(resourceName: "pass").maskWithColor(color: .blueBorderColor())
    }
    
    @IBAction func btnChangePasswordTapped(_ sender: UIButton) {
        if validateTextFields(){
            changePasswordApi()
        }
    }
    
    @IBAction func btnShowHidePasswordTapped(_ sender: UIButton) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        showPassword = !showPassword
        if showPassword == true {
            btnShowPassword.setImage(#imageLiteral(resourceName: "notviewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        } else {
            btnShowPassword.setImage(#imageLiteral(resourceName: "viewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        }
    }
    
    func setRootAsLoginScreen() {
        let loginVC = LoginVC.instantiate(from: .login)
        self.navigationController?.viewControllers = [loginVC]
        windowSceneDelegate?.window?.rootViewController = navigationController
        windowSceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func changePasswordApi(){
        guard let username = self.username, let enc = self.enc, let otp = otpTF.text, let password = passwordTF.text, let otpInt = Int(otp) else { return }
        Remote.shared.changePassword(otp: otpInt, username: username, password: password, enc: enc) { data in
            showSnackBar(with: data?.errorMessage ?? "", duration: .middle)
            if data?.isValid == true {
                self.setRootAsLoginScreen()
            }
        }
    }
    
    func validateTextFields() -> Bool{
        if otpTF.text == "" {
            showSnackBar(with: LocalizedString.otp, duration: .short)
            return false
        }else if passwordTF.text == "" {
            showSnackBar(with: LocalizedString.password, duration: .short)
            return false
            
        }
        return true
    }
    
}
