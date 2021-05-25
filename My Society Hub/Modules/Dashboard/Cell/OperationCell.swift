//
//  OperationCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class OperationCell: UICollectionViewCell {

    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    
    func configureCell(_ model: menuItemsModel){
        lblMenu.text = model.name
        imgMenu.image = model.image
    }
    
}
