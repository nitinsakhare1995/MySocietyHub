//
//  NewNoticeVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import DropDown

class NewNoticeVC: BaseViewController {
    
    @IBOutlet weak var imgAttachment: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var lblNoticType: UILabel!
    @IBOutlet weak var noticeNameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var lblNoticeExpire: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgCalendar: UIImageView!
    
    var noticeTypeDropdown = DropDown()
    var noticeTypelist = [NoticeTableModel]()
    
    var selectedNoticeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoticeExpire.text = ""
        
        getNoticeTypeList()
        
        imgArrow.image = #imageLiteral(resourceName: "down_arrow").maskWithColor(color: .appOrangeColor())
        imgCalendar.image = #imageLiteral(resourceName: "calendar").maskWithColor(color: .appOrangeColor())
        btnAddImage.setImage(#imageLiteral(resourceName: "add").maskWithColor(color: .appOrangeColor()), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Add Notice"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    @IBAction func btnSelectNoticeTapped(_ sender: UIButton) {
        noticeTypeDropdown.show()
    }
    
    @IBAction func btnNoticeExpiryTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitNoticeTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnAddImageTapped(_ sender: UIButton) {
    }
    
    
    
}

extension NewNoticeVC {
    
    func getNoticeTypeList(){
        Remote.shared.getNoticeType { data in
            self.noticeTypelist = data?.table ?? []
            
            self.noticeTypeDropdown.dataSource = self.noticeTypelist.compactMap({ return $0.name })
            self.noticeTypeDropdown.anchorView = self.lblNoticType
            self.noticeTypeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblNoticType.text = item
                self.selectedNoticeId = self.noticeTypelist[index].id
            }
            
        }
    }
    
}
