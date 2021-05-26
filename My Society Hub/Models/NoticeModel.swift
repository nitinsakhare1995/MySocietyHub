//
//  NoticeModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 26/05/21.
//

import Foundation
import ObjectMapper

struct NoticeModel : Mappable {
    var table : [NoticeTableModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        table <- map["Table"]
    }

}

struct NoticeTableModel : Mappable {
    var id : String?
    var rowNo : Int?
    var noticeType : String?
    var noticeSubject : String?
    var description : String?
    var noticeDate : String?
    var expiryDate : String?
    var noticeID : String?
    var documentID : String?
    var attachment : String?
    var remotefilepath : String?
    var downloadPath : String?
    var billCode : String?
    var name : String?
    var customerID : String?
    var complaintNature : String?
    var complaintType : String?
    var category : String?
    var complaintDate : String?
    var status : String?
    var urgent : String?
    var remoteFilePath : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["ID"]
        rowNo <- map["RowNo"]
        noticeType <- map["NoticeType"]
        noticeSubject <- map["NoticeSubject"]
        description <- map["Description"]
        noticeDate <- map["NoticeDate"]
        expiryDate <- map["ExpiryDate"]
        noticeID <- map["NoticeID"]
        documentID <- map["DocumentID"]
        attachment <- map["Attachment"]
        remotefilepath <- map["remotefilepath"]
        downloadPath <- map["DownloadPath"]
        billCode <- map["BillCode"]
        name <- map["Name"]
        customerID <- map["CustomerID"]
        complaintNature <- map["ComplaintNature"]
        complaintType <- map["ComplaintType"]
        category <- map["Category"]
        complaintDate <- map["ComplaintDate"]
        status <- map["Status"]
        urgent <- map["Urgent"]
        remoteFilePath <- map["RemoteFilePath"]
    }

}
