//
//  NoticeDetailsVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import Kingfisher

class NoticeDetailsVC: BaseViewController {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblNoticeSubject: UILabel!
    @IBOutlet weak var lblNoticeDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgAttachment: UIImageView!
    
    var data: NoticeTableModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnClose.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .blueBorderColor()), for: .normal)
        
        let imgURL = URL(string: data?.downloadPath ?? "")
        imgAttachment.kf.setImage(with: imgURL)
        lblNoticeSubject.text = data?.noticeSubject
        lblNoticeDescription.text = data?.description
        
        let noticeDate = showDate(createdAt: data?.noticeDate ?? "", dateFormat: "dd-MMM-yyyy")
        let expiryDate = showDate(createdAt: data?.expiryDate ?? "", dateFormat: "dd-MMM-yyyy")
        
        lblDate.text = "\(expiryDate)                      \(noticeDate)"
        
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
}
