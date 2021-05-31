//
//  ComplaintDetailsVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class ComplaintDetailsVC: BaseViewController {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRowNo: UILabel!
    
    @IBOutlet weak var lblComplaintNature: UILabel!
    @IBOutlet weak var lblComplaintDescription: UILabel!
    @IBOutlet weak var lblComplaintType: UILabel!
    @IBOutlet weak var lblComplaintCategory: UILabel!
    
    @IBOutlet weak var lblComplaintDate: UILabel!
    @IBOutlet weak var lblComplaintBy: UILabel!
    @IBOutlet weak var remarkTF: UITextField!
    
    @IBOutlet weak var imgAttachment: UIImageView!
    @IBOutlet weak var txtFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var btnResolvedHeight: NSLayoutConstraint!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var openStatusViewLine: UIView!
    
    var data: NoticeTableModel?
    var controller: ComplaintVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ComplaintDetailsVC.openImage))
        imgAttachment.addGestureRecognizer(tap)
        imgAttachment.isUserInteractionEnabled = true
        
    }
    
    func setUIData(){
        
        btnClose.setImage(#imageLiteral(resourceName: "cancel").maskWithColor(color: .appOrangeColor()), for: .normal)
        txtFieldHeight.constant = 40
        btnResolvedHeight.constant = 40
        openStatusViewLine.isHidden = false
        
        lblRowNo.text = data?.rowNo?.description
        lblComplaintNature.text = data?.complaintNature
        lblComplaintDate.text = showDate(createdAt: data?.complaintDate ?? "", dateFormat: "dd-MMM-yyyy")
        lblStatus.text = data?.status
        lblComplaintType.text = data?.complaintType
        lblComplaintBy.text = data?.name
        lblComplaintCategory.text = data?.category
        lblComplaintDescription.text = data?.description
        statusView.backgroundColor = .appOrangeColor()
        let imgURL = URL(string: data?.downloadPath ?? "")
        imgAttachment.kf.setImage(with: imgURL)
        
        if data?.status?.lowercased() == "closed"{
            statusView.backgroundColor = .systemGreen
            txtFieldHeight.constant = 0
            btnResolvedHeight.constant = 0
            openStatusViewLine.isHidden = true
        }
    }
    
    @objc func openImage() {
        if data?.downloadPath != nil {
            if let popupViewController = UIStoryboard(name: Storyboard.userAccount.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ImagePopUpVC") as? ImagePopUpVC {
                popupViewController.modalPresentationStyle = .custom
                popupViewController.modalTransitionStyle = .crossDissolve
                popupViewController.imgURL = data?.downloadPath
                self.present(popupViewController, animated: true)
            }
        }
    }
    
    func closeComplaint(){
        guard let docId = data?.documentID else { return }
        Remote.shared.closeComplaint(documentID: docId, remarks: self.remarkTF.text ?? "") { data in
            self.dismiss(animated: true) { [self] in
                controller?.getComplaintList()
            }
        }
    }
    
    @IBAction func btnMarkAsResolvedTapped(_ sender: UIButton) {
        closeComplaint()
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
