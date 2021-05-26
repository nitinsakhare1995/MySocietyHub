//
//  SignatoryDetailsCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class SignatoryDetailsCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblSignatory: UILabel!
    @IBOutlet weak var lblNme: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    
    var callButtonTapped : (() -> ()) = {}
    var emailButtonTapped : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
        btnEmail.setImage(#imageLiteral(resourceName: "mail").maskWithColor(color: .appOrangeColor()), for: .normal)
        btnPhone.setImage(#imageLiteral(resourceName: "call").maskWithColor(color: .appOrangeColor()), for: .normal)
        
    }
    
    func configureCell(_ model: SignatoryTableModel){
        lblNme.text = model.name
        lblSignatory.text = model.signatory
    }
    
    @IBAction func btnEmailTapped(_ sender: UIButton) {
        emailButtonTapped()
    }
    
    @IBAction func btnPhoneTapped(_ sender: UIButton) {
        callButtonTapped()
    }
}
