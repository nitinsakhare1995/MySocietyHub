//
//  MiniStatementCell.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 27/05/21.
//

import UIKit

class MiniStatementCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRef: UILabel!
    @IBOutlet weak var lblDebit: UILabel!
    @IBOutlet weak var lblCredit: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var btnViewDoc: UIButton!
    
    var viewDocumentBtnTapped : (() -> ()) = {}
    
    func configureCell(_ model: MiniStatementTableModel) {
        lblDate.text = showDate(createdAt: model.documentDate ?? "", dateFormat: "dd-MMM-yyyy")
        lblRef.text = model.ref
        lblDebit.text = model.debit?.description
        lblCredit.text = model.credit?.description
        lblBalance.text = model.balAmt?.description
        btnViewDoc.isHidden = true
        if model.isDownload == 1 {
            btnViewDoc.isHidden = false
        }
    }
    
    @IBAction func btnViewDocTapped(_ sender: UIButton) {
        viewDocumentBtnTapped()
    }
    
}
