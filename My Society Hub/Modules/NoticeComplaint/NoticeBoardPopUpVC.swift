//
//  NoticeBoardPopUpVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 29/05/21.
//

import UIKit

class NoticeBoardPopUpVC: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lblNoticeType: UILabel!
    @IBOutlet weak var lblNoticeSubject: UILabel!
    @IBOutlet weak var lblNoticeDescription: UILabel!
    @IBOutlet weak var lblNoticeDare: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    
    var data: NoticeTableModel?
    var controller: DashboardVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        btnDownload.setImage(#imageLiteral(resourceName: "download").maskWithColor(color: .appOrangeColor()), for: .normal)
        
        lblNoticeType.text = data?.noticeType
        lblNoticeSubject.text = data?.noticeSubject
        lblNoticeDescription.text = data?.description
        lblNoticeDare.text = "Notice Date: \(showDate(createdAt: data?.noticeDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        lblExpiryDate.text = "Expiry Date: \(showDate(createdAt: data?.expiryDate ?? "", dateFormat: "dd-MMM-yyyy"))"
        btnDownload.isHidden = true
        if data?.downloadPath != nil {
            btnDownload.isHidden = false
        }
        
    }
    
    @IBAction func btnDownloadTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let url = self.data?.downloadPath {
                self.controller?.storeAndShare(withURLString: url)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            if touch?.view != self.popUpView
            { self.dismiss(animated: true, completion: nil) }
        }
    
}
