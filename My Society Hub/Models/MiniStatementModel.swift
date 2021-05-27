//
//  MiniStatementModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 27/05/21.
//

import Foundation
import ObjectMapper

struct MiniStatementModel : Mappable {
    var table : [MiniStatementTableModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        table <- map["Table"]
    }

}

struct MiniStatementTableModel : Mappable {
    var seqNo : Int?
    var grpNo : Int?
    var companyID : String?
    var locationID : String?
    var divisionID : String?
    var customerID : String?
    var documentID : String?
    var transactID : String?
    var displayNumber : String?
    var documentDate : String?
    var ref : String?
    var accountCode : String?
    var accountName : String?
    var narration : String?
    var chqNo : String?
    var chqDate : String?
    var against : String?
    var debit : Double?
    var credit : Double?
    var balAmt : Double?
    var dueDate : String?
    var interest : Double?
    var interestPaid : Double?
    var interestOn : Double?
    var cancelDebit : Double?
    var cancelCredit : Double?
    var status : String?
    var documentTypeCode : String?
    var isDownload : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        seqNo <- map["SeqNo"]
        grpNo <- map["GrpNo"]
        companyID <- map["CompanyID"]
        locationID <- map["LocationID"]
        divisionID <- map["DivisionID"]
        customerID <- map["CustomerID"]
        documentID <- map["DocumentID"]
        transactID <- map["TransactID"]
        displayNumber <- map["DisplayNumber"]
        documentDate <- map["DocumentDate"]
        ref <- map["Ref"]
        accountCode <- map["AccountCode"]
        accountName <- map["AccountName"]
        narration <- map["Narration"]
        chqNo <- map["ChqNo"]
        chqDate <- map["ChqDate"]
        against <- map["Against"]
        debit <- map["Debit"]
        credit <- map["Credit"]
        balAmt <- map["BalAmt"]
        dueDate <- map["DueDate"]
        interest <- map["Interest"]
        interestPaid <- map["InterestPaid"]
        interestOn <- map["InterestOn"]
        cancelDebit <- map["CancelDebit"]
        cancelCredit <- map["CancelCredit"]
        status <- map["Status"]
        documentTypeCode <- map["DocumentTypeCode"]
        isDownload <- map["IsDownload"]
    }

}
