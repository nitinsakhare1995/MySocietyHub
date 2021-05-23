//
//  EmergencyCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class EmergencyCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
        
    }
    
}
