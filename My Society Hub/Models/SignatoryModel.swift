//
//  SignatoryModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 26/05/21.
//

import Foundation
import ObjectMapper

struct SignatoryModel : Mappable {
    var table : [SignatoryTableModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        table <- map["Table"]
    }

}

struct SignatoryTableModel : Mappable {
    var signatory : String?
    var name : String?
    var email : String?
    var phoneNumber : String?
    var account : String?
    var amount : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        signatory <- map["Signatory"]
        name <- map["Name"]
        email <- map["Email"]
        phoneNumber <- map["PhoneNumber"]
        account <- map["Account"]
        amount <- map["Amount"]
    }

}
