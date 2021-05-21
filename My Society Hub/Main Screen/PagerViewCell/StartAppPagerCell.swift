//
//  StartAppPagerCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 21/05/21.
//

import UIKit

class StartAppPagerCell: UICollectionViewCell {

    @IBOutlet weak var imgPager: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    

    func configureCell(_ model: PagerScreensModel){
        imgPager.image = model.image
        lblName.text = model.name
        lblDesc.text = model.description
        self.backgroundColor = model.color
    }
    
}
