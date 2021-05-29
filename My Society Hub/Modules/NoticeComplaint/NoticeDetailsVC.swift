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
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NoticeDetailsVC.openImage))
        imgAttachment.addGestureRecognizer(tap)
        imgAttachment.isUserInteractionEnabled = true
        
        btnClose.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .blueBorderColor()), for: .normal)
        
        let imgURL = URL(string: data?.downloadPath ?? "")
        imgAttachment.kf.setImage(with: imgURL)
        lblNoticeSubject.text = data?.noticeSubject
        lblNoticeDescription.text = data?.description
        
        let noticeDate = showDate(createdAt: data?.noticeDate ?? "", dateFormat: "dd-MMM-yyyy")
        let expiryDate = showDate(createdAt: data?.expiryDate ?? "", dateFormat: "dd-MMM-yyyy")
        
        lblDate.text = "\(expiryDate)                      \(noticeDate)"
        
    }
    
    @objc func openImage() {
        if let popupViewController = UIStoryboard(name: Storyboard.userAccount.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ImagePopUpVC") as? ImagePopUpVC {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.imgURL = data?.downloadPath
            self.present(popupViewController, animated: true)
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
