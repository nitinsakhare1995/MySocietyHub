//
//  LoginModel.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 26/05/21.
//

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var token : String?
    var expires : String?
    var sessionid : String?
    var refreshcode : String?
    var attachmentID : Int?
    var downloadpath : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        expires <- map["expires"]
        sessionid <- map["sessionid"]
        refreshcode <- map["refreshcode"]
        attachmentID <- map["AttachmentID"]
        downloadpath <- map["downloadpath"]
    }

}
