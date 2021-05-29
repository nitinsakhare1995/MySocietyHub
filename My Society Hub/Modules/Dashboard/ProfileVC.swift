//
//  ProfileVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 29/05/21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblContact: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.tag = TabbarItemTag.thirdViewConroller.rawValue
        
        getUserData()
    }

    func getUserData(){
        Remote.shared.getUserData { data in
            self.lblName.text = data?.table?.first?.customerName
            self.lblDesignation.text = data?.table?.first?.entityType
            self.emailTF.text = data?.table?.first?.eMail
            self.addressTF.text = data?.table?.first?.locationName
        }
    }

}
