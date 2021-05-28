//
//  NoticeBoardCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 22/05/21.
//

import UIKit

class NoticeBoardCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNoticeType: UILabel!
    @IBOutlet weak var lblNoticeSubject: UILabel!
    @IBOutlet weak var lblNoticeDescription: UILabel!
    @IBOutlet weak var lblNoticeDate: UILabel!
    @IBOutlet weak var lblNoticeExpiryDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    var downloadBtnTapped : (() -> ()) = {}
    var readMoreBtnTapped : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDownload.setImage(#imageLiteral(resourceName: "download").maskWithColor(color: .appOrangeColor()), for: .normal)
        mainView.dropShadow()
    }
    
    func configureCell(_ model: NoticeTableModel){
        lblNoticeType.text = model.noticeType
        lblNoticeSubject.text = model.noticeSubject
        lblNoticeDescription.text = model.description
        lblNoticeDate.text = "Notice Date: \(showDate(createdAt: model.noticeDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        lblNoticeExpiryDate.text = "Expiry Date: \(showDate(createdAt: model.expiryDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        btnDownload.isHidden = true
        if model.downloadPath != nil {
            btnDownload.isHidden = false
        }
    }
    
    @IBAction func btnDownloadNoticeTapped(_ sender: UIButton) {
        downloadBtnTapped()
    }
    
    @IBAction func btReadMoreTapped(_ sender: UIButton) {
        readMoreBtnTapped()
    }
    
}
