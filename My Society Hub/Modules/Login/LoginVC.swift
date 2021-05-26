//
//  LoginVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var btnPassword: UIButton!

    @IBOutlet weak var tiltView: UIView!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var showPassword = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tiltView.rotate(degrees: -45)
        
        changeImageColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func changeImageColors(){
        btnPassword.setImage(#imageLiteral(resourceName: "viewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        imgUser.image = #imageLiteral(resourceName: "user").maskWithColor(color: .blueBorderColor())
        imgPassword.image = #imageLiteral(resourceName: "pass").maskWithColor(color: .blueBorderColor())
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        let forgotPasswordVC = ForgotPasswordVC.instantiate(from: .login)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if validateTextFields(){
            loginUserApi()
        }
    }
    
    @IBAction func btnPasswordShowHideTapped(_ sender: UIButton) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        showPassword = !showPassword
        if showPassword == true {
            btnPassword.setImage(#imageLiteral(resourceName: "notviewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        } else {
            btnPassword.setImage(#imageLiteral(resourceName: "viewpass").maskWithColor(color: .blueBorderColor()), for: .normal)
        }
    }
    
    func setRootAsDashboardScreen() {
        let vc = UIStoryboard(name: Storyboard.dashboard.rawValue, bundle: nil).instantiateViewController(identifier: "DashboardTabBarVC") as! DashboardTabBarVC
        self.navigationController?.viewControllers = [vc]
        windowSceneDelegate?.window?.rootViewController = navigationController
        windowSceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func loginUserApi(){
        guard let username = usernameTF.text, let password = passwordTF.text else { return }
        Remote.shared.loginUser(username: username, password: password) { data in
            UserDefaults.standard.setValue(data?.token, forKey: DefaultKeys.UDAccessToken)
            UserDefaults.standard.setValue(true, forKey: DefaultKeys.UDUserLoggedIn)
            UserDefaults.standard.synchronize()
            self.setRootAsDashboardScreen()
        }
        
    }
    
    func validateTextFields() -> Bool{
        if usernameTF.text == "" {
            showSnackBar(with: "Please enter Mobile number or Email id", duration: .short)
            return false
        } else if let validphone = usernameTF.text, validphone.isValidPhone() || validphone.isValidEmail() {
            return true
        } else {
            showSnackBar(with: "Mobile number or Email id invalid", duration: .short)
            return false
        }
        if passwordTF.text == "" {
            showSnackBar(with: "Please enter password", duration: .short)
            return false
        }
        return true
    }
    
}

extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

}
