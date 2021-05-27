//
//  EmergencyCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class EmergencyCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblEmergency: UILabel!
    @IBOutlet weak var imgEmergency: UIImageView!
    @IBOutlet weak var imgCall: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
        imgCall.image = #imageLiteral(resourceName: "call").maskWithColor(color: .appOrangeColor())
        
    }
    
    func configureCell(_ model: EmergencyModel){
        lblEmergency.text = model.name
        imgEmergency.image = model.image
    }
    
}
