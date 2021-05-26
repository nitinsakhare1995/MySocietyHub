//
//  PasswordModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 26/05/21.
//

import Foundation
import ObjectMapper

struct PasswordModel : Mappable {
    var data : PasswordDataModel?
    var enc : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        data <- map["Data"]
        enc <- map["Enc"]
    }

}

struct PasswordTableModel : Mappable {
    var isValid : Bool?
    var errorMessage : String?
    var name : String?
    var userData : String?
    var eMail : String?
    var phoneNumber : String?
    var locationID : String?
    var companyID : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        isValid <- map["IsValid"]
        errorMessage <- map["ErrorMessage"]
        name <- map["Name"]
        userData <- map["UserData"]
        eMail <- map["EMail"]
        phoneNumber <- map["PhoneNumber"]
        locationID <- map["LocationID"]
        companyID <- map["CompanyID"]
    }

}

struct PasswordDataModel : Mappable {
    var table : [PasswordTableModel]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        table <- map["Table"]
    }

}
