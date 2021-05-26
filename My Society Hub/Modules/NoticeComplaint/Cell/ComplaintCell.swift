//
//  ComplaintCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 23/05/21.
//

import UIKit

class ComplaintCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblComplaintDate: UILabel!
    @IBOutlet weak var viewComplaintStatus: UIView!
    @IBOutlet weak var lblComplaintStatus: UILabel!
    @IBOutlet weak var lblComplaintType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.dropShadow()
        
    }

    func configureCell(_ model: NoticeTableModel){
        lblComplaintDate.text = showDate(createdAt: model.complaintDate ?? "", dateFormat: "dd-MMM-yyyy")
        lblComplaintStatus.text = model.status
        lblComplaintType.text = model.complaintType
        lblName.text = model.name
        lblCategory.text = model.category
        viewComplaintStatus.backgroundColor = .appOrangeColor()
        if model.status?.lowercased() == "closed"{
            viewComplaintStatus.backgroundColor = .systemGreen
        }
    }
    
}

