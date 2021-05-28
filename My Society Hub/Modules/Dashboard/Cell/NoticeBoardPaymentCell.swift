//
//  NoticeBoardPaymentCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 28/05/21.
//

import UIKit

class NoticeBoardPaymentCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    
    var payNowBtnTapped : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadow()
    }
    
    @IBAction func btnPayNowTapped(_ sender: UIButton) {
        payNowBtnTapped()
    }
    
}
