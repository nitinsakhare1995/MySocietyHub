//
//  UserModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 26/05/21.
//

import Foundation
import ObjectMapper

struct UserModel : Mappable {
    var table : [UserTableModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        table <- map["Table"]
    }

}

struct UserTableModel : Mappable {
    var customerID : String?
    var customerName : String?
    var customerCode : String?
    var wing : String?
    var flatNo : String?
    var bldgNo : String?
    var userName : String?
    var isAllowEdit : Bool?
    var isAllowAdd : Bool?
    var isAllowSearch : Bool?
    var outstandingAmount : Double?
    var asOnDate : String?
    var eMail : String?
    var phoneNumber : String?
    var billCode : String?
    var locationName : String?
    var companyName : String?
    var companyWebsite : String?
    var locationID : String?
    var entityType : String?
    var isPayAvailable : Bool?
    var loanBy : String?
    var flatArea : String?
    var installationDate : String?
    var isSystem : Bool?
    var isPaymentBankSet : Bool?
    var paymentRedirectLink : String?
    var qrCodeLink : String?
    var isPaymentRedirection : Bool?
    var isWebsiteRedirection : Bool?
    var pg : String?
    var lastBillDocumentID : String?
    var lastBillDTCode : String?
    var isCommitteMember : Bool?
    var isManager : Bool?
    var isAdministrator : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        customerID <- map["CustomerID"]
        customerName <- map["CustomerName"]
        customerCode <- map["CustomerCode"]
        wing <- map["Wing"]
        flatNo <- map["FlatNo"]
        bldgNo <- map["BldgNo"]
        userName <- map["UserName"]
        isAllowEdit <- map["IsAllowEdit"]
        isAllowAdd <- map["IsAllowAdd"]
        isAllowSearch <- map["IsAllowSearch"]
        outstandingAmount <- map["OutstandingAmount"]
        asOnDate <- map["AsOnDate"]
        eMail <- map["EMail"]
        phoneNumber <- map["PhoneNumber"]
        billCode <- map["BillCode"]
        locationName <- map["LocationName"]
        companyName <- map["CompanyName"]
        companyWebsite <- map["CompanyWebsite"]
        locationID <- map["LocationID"]
        entityType <- map["EntityType"]
        isPayAvailable <- map["IsPayAvailable"]
        loanBy <- map["LoanBy"]
        flatArea <- map["FlatArea"]
        installationDate <- map["InstallationDate"]
        isSystem <- map["IsSystem"]
        isPaymentBankSet <- map["IsPaymentBankSet"]
        paymentRedirectLink <- map["PaymentRedirectLink"]
        qrCodeLink <- map["QrCodeLink"]
        isPaymentRedirection <- map["IsPaymentRedirection"]
        isWebsiteRedirection <- map["IsWebsiteRedirection"]
        pg <- map["pg"]
        lastBillDocumentID <- map["LastBillDocumentID"]
        lastBillDTCode <- map["LastBillDTCode"]
        isCommitteMember <- map["IsCommitteMember"]
        isManager <- map["IsManager"]
        isAdministrator <- map["IsAdministrator"]
    }

}
