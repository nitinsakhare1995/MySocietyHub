//
//  BillSlabCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class BillSlabCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
        
    }

    func configureCell(_ model: SignatoryTableModel){
        lblAccount.text = model.account
        if let rupee = model.amount?.description {
            lblAmount.text = "₹ \(rupee).0"
        }else{
            lblAmount.text = "₹ 00.0"
        }
        
    }
    
    
}
