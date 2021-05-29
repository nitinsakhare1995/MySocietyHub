//
//  NewComplaintVC.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit
import DropDown
import DLRadioButton

class NewComplaintVC: BaseViewController {
    
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var imgArrow1: UIImageView!
    @IBOutlet weak var imgArrow2: UIImageView!
    @IBOutlet weak var imgArrow3: UIImageView!
    @IBOutlet weak var lblComplaintNature: UILabel!
    @IBOutlet weak var lblComplaintType: UILabel!
    @IBOutlet weak var lblComplaintCategory: UILabel!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var imgAttachment: UIImageView!
    
    var complaintNatureDropdown = DropDown()
    var complaintNaturelist = [NoticeTableModel]()
    var selectedComplaintNatureId: String?
    
    var complaintTypeDropdown = DropDown()
    var complaintTypelist = [NoticeTableModel]()
    var selectedcomplaintTypeId: String?
    
    var complaintCategoryDropdown = DropDown()
    var complaintCategorylist = [NoticeTableModel]()
    var selectedcomplaintCategoryId: String?
    
    var isComplaintUrgent: Bool?
    
    var attachmentID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageColors()
        
        getComplaintType()
        getComplaintNature()
        getComplaintCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Add Complaint"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func setImageColors(){
        imgArrow1.image = #imageLiteral(resourceName: "down_arrow").maskWithColor(color: .appOrangeColor())
        imgArrow2.image = #imageLiteral(resourceName: "down_arrow").maskWithColor(color: .appOrangeColor())
        imgArrow3.image = #imageLiteral(resourceName: "down_arrow").maskWithColor(color: .appOrangeColor())
        btnAddImage.setImage(#imageLiteral(resourceName: "add").maskWithColor(color: .appOrangeColor()), for: .normal)
    }
    
    
    @IBAction func btnSelectComplaintNatureTapped(_ sender: UIButton) {
        complaintNatureDropdown.show()
    }
    
    @IBAction func btnComplaintTypeTapped(_ sender: UIButton) {
        complaintTypeDropdown.show()
    }
    
    @IBAction func btnComplaintCategoryTapped(_ sender: UIButton) {
        complaintCategoryDropdown.show()
    }
    
    @IBAction func btnRaiseComplaintTapped(_ sender: UIButton) {
        if validateTextFields(){
            addNewComplaint()
        }
    }
    
    @IBAction func btnAddImageTapped(_ sender: UIButton) {
        let picker = FilePicker.instantiate(with: [.camera, .gallery])
        picker.modalPresentationStyle = .overCurrentContext
        self.present(picker, animated: true, completion: nil)
        picker.didSelectImageAttachment = { attachment in
            self.imgAttachment.image = attachment.image
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
    
    func addNewComplaint(){
        guard let natureID = self.selectedComplaintNatureId, let complaintTypeID = self.selectedcomplaintTypeId, let categoryID = self.selectedcomplaintCategoryId, let isUrgent = self.isComplaintUrgent, let description = self.descriptionTF.text, let onBehalfCustomerID = UserDefaults.standard.string(forKey: DefaultKeys.UDUserID) else { return }
        Remote.shared.addNewComplaint(natureID: natureID, complaintTypeID: complaintTypeID, categoryID: categoryID, isUrgent: isUrgent, description: description, attachmentID: self.attachmentID, onBehalfCustomerID: onBehalfCustomerID) { data in
            showSnackBar(with: data?.table?.first?.message ?? "", duration: .middle)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnYesTapped(_ sender: UIButton) {
        isComplaintUrgent = true
    }
    
    @IBAction func btnNoTapped(_ sender: UIButton) {
        isComplaintUrgent = false
    }
    
    func validateTextFields() -> Bool{
        if selectedComplaintNatureId == nil {
            showSnackBar(with: "Please select Complaint Nature", duration: .short)
            return false
        }else if selectedcomplaintTypeId == nil {
            showSnackBar(with: "Please select Complaint type", duration: .short)
            return false
        }else if selectedcomplaintCategoryId == nil {
            showSnackBar(with: "Please select Complaint category", duration: .short)
            return false
        }else if isComplaintUrgent == nil {
            showSnackBar(with: "Please select is your Compalint urgent or no", duration: .short)
            return false
        }else if descriptionTF.text == "" {
            showSnackBar(with: "Please enter Notice description", duration: .short)
            return false
        }
        return true
    }
    
}

extension NewComplaintVC {
    
    func getComplaintNature(){
        Remote.shared.getComplaintNature { data in
            self.complaintNaturelist = data?.table ?? []
            
            self.complaintNatureDropdown.dataSource = self.complaintNaturelist.compactMap({ return $0.name })
            self.complaintNatureDropdown.anchorView = self.lblComplaintNature
            self.complaintNatureDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblComplaintNature.text = item
                self.selectedComplaintNatureId = self.complaintNaturelist[index].id
            }
            
        }
    }
    
    func getComplaintType(){
        Remote.shared.getComplaintType { data in
            self.complaintTypelist = data?.table ?? []
            
            self.complaintTypeDropdown.dataSource = self.complaintTypelist.compactMap({ return $0.name })
            self.complaintTypeDropdown.anchorView = self.lblComplaintType
            self.complaintTypeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblComplaintType.text = item
                self.selectedcomplaintTypeId = self.complaintTypelist[index].id
            }
            
        }
    }
    
    func getComplaintCategory(){
        Remote.shared.getComplaintCategory { data in
            self.complaintCategorylist = data?.table ?? []
            
            self.complaintCategoryDropdown.dataSource = self.complaintCategorylist.compactMap({ return $0.name })
            self.complaintCategoryDropdown.anchorView = self.lblComplaintCategory
            self.complaintCategoryDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblComplaintCategory.text = item
                self.selectedcomplaintCategoryId = self.complaintCategorylist[index].id
            }
            
        }
    }
    
}
