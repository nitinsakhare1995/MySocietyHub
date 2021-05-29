//
//  PayNowVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class PayNowVC: BaseViewController {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var paymentAmountTF: UITextField!
    @IBOutlet weak var btnAgree: UIButton!
    
    var isChecked = false
    var userData: UserTableModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.tag = TabbarItemTag.firstViewController.rawValue
        getUserData()
        
    }
    
    func getUserData(){
        Remote.shared.getUserData { data in
            self.userData = data?.table?.first
            self.lblName.text = data?.table?.first?.customerName
            self.lblAmount.text = "₹ \(data?.table?.first?.outstandingAmount?.description ?? "")" 
            self.lblEmail.text = data?.table?.first?.eMail
            self.btnPayNow.setTitle("Pay Now", for: .normal)
        }
    }
    
    @IBAction func btnAgreeTapped(_ sender: UIButton) {
        isChecked = !isChecked
        if isChecked == true {
            let image = UIImage(systemName: "checkmark.square.fill")
            btnAgree.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "square")
            btnAgree.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnPayNowTapped(_ sender: UIButton) {
        if isChecked == false {
            showSnackBar(with: "Please agree with terms and conditions", duration: .middle)
        }else{
            validateTextFieldsAndCallApi()
        }
    }
    
    @IBAction func btnDownloadBillTapped(_ sender: UIButton) {
        
    }
    
    func validateTextFieldsAndCallApi() {
        if mobileNumberTF.text == "" {
            showSnackBar(with: "Please enter Mobile Number", duration: .short)
        } else if paymentAmountTF.text == ""{
            showSnackBar(with: "Please enter Payment amount", duration: .short)
        }else if let validphone = mobileNumberTF.text, validphone.isValidPhone() {
            callPaymentAPI()
        }else{
            showSnackBar(with: "Mobile Number invalid", duration: .short)
        }
    }
    
    func callPaymentAPI(){
        guard let amount = paymentAmountTF.text, let amountInt = Int(amount), let firstName = self.userData?.userName, let email = self.userData?.eMail, let phone = self.mobileNumberTF.text else { return }
        Remote.shared.makePayment(amount: amountInt, firstname: firstName, email: email, phone: phone) { data in
            let vc = WebViewVC.instantiate(from: .dashboard)
            vc.url = data?.url
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
