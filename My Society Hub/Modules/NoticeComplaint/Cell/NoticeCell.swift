//
//  Notice Cell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class NoticeCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblNoticeSubject: UILabel!
    @IBOutlet weak var lblNoticeDate: UILabel!
    @IBOutlet weak var lblNoticeExpiryDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
//        lblNoticeSubject.sizeToFit()
//        lblNoticeSubject.lineBreakMode = .byWordWrapping

    }
    
//     override func updateConstraints() {
//        lblNoticeSubject.preferredMaxLayoutWidth = mainView.bounds.width
//        super.updateConstraints()
//    }
    
    func configureCell(_ model: NoticeTableModel){
        
        lblNoticeSubject.text =  model.noticeSubject
        lblNoticeDate.text = "Notice Date-\(showDate(createdAt: model.noticeDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        lblNoticeExpiryDate.text = "Expiry Date-\(showDate(createdAt: model.expiryDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        
//        lblNoticeSubject.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
//        productNameLabel.preferredMaxLayoutWidth = self.frame.size.width * 0.6
    }
//    model.noticeSubject
}
