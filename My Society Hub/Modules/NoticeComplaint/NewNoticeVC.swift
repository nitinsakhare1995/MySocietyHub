//
//  NewNoticeVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import DropDown

class NewNoticeVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imgAttachment: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var lblNoticType: UILabel!
    @IBOutlet weak var noticeNameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgCalendar: UIImageView!
    @IBOutlet weak var noticeExpiryTF: UITextField!
    
    var noticeTypeDropdown = DropDown()
    var noticeTypelist = [NoticeTableModel]()
    var attachmentID: Int?
    var selectedNoticeExpiryDate: String?
    let datePicker = UIDatePicker()
    
    var selectedNoticeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 16, to: Date())
        
        noticeNameTF.setLeftPaddingPoints(12)
        noticeExpiryTF.delegate = self
        noticeExpiryTF.tintColor = .clear
        
        showDatePicker()
        
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
    
    @IBAction func btnSubmitNoticeTapped(_ sender: UIButton) {
        if validateTextFields(){
            addNewNotice()
        }
    }
    
    @IBAction func btnAddImageTapped(_ sender: UIButton) {
        let picker = FilePicker.instantiate(with: [.camera, .gallery])
        picker.modalPresentationStyle = .overCurrentContext
        self.present(picker, animated: true, completion: nil)
        picker.didSelectImageAttachment = { attachment in
            self.uploadFileOnServer(image: attachment.image)
        }
    }
    
    func uploadFileOnServer(image: UIImage){
        Remote.shared.uploadFileOnServer(image: image){ details in
            if let id = details?.attachmentID {
                self.imgAttachment.image = image
                self.attachmentID = id
            }else {
                showSnackBar(with: LocalizedString.apiError, duration: .middle)
            }
        }
    }
    
    func addNewNotice(){
        guard let noticeTypeID = self.selectedNoticeId, let noticeSubject = noticeNameTF.text, let noticeDescription = descriptionTF.text, let expiryDate = self.selectedNoticeExpiryDate else { return }
        Remote.shared.addNewNotice(noticeTypeID: noticeTypeID, noticeSubject: noticeSubject, noticeDescription: noticeDescription, noticeDate: Date().string(format: "yyyy-MM-dd"), expiryDate: expiryDate, attachmentID: self.attachmentID ?? 0) { data in
            showSnackBar(with: data?.table?.first?.message ?? "", duration: .middle)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        noticeExpiryTF.inputAccessoryView = toolbar
        noticeExpiryTF.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        noticeExpiryTF.text = formatter.string(from: datePicker.date)
        self.selectedNoticeExpiryDate = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func validateTextFields() -> Bool{
        if selectedNoticeId == nil {
            showSnackBar(with: "Please select Notice type", duration: .short)
            return false
        }else if noticeNameTF.text == "" {
            showSnackBar(with: "Please enter Notice name", duration: .short)
            return false
        }else if descriptionTF.text == "" {
            showSnackBar(with: "Please enter Notice description", duration: .short)
            return false
        }else if noticeExpiryTF.text == "" {
            showSnackBar(with: "Please select Notice expiry date", duration: .short)
            return false
        }
        return true
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
