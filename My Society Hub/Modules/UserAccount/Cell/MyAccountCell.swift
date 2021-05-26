//
//  MyAccountCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class MyAccountCell: UITableViewCell {
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var imgNext: UIImageView!
    
    func configureCell(_ model: menuItemsModel) {
        imgNext.image = #imageLiteral(resourceName: "right_arrow").maskWithColor(color: .blueBorderColor())
        lblItem.text = model.name
        imgItem.image = model.image
        
    }
    
}
