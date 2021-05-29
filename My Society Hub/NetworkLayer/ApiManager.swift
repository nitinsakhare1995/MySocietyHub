//
//  ApiManager.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 25/05/21.
//

import Foundation
import Alamofire

enum Constants: String {
    case baseURLPath
    case accessToken
    case todaysDate
    case lastYearDate
    
    var rawValue: String {
        get {
            switch self {
            case .baseURLPath: return AppSettings.baseUrl
            case .accessToken: return "Bearer " + (UserDefaults.standard.string(forKey: DefaultKeys.UDAccessToken) ?? "")
            case .todaysDate: return Date().string(format: "yyyy-MM-dd")
            case .lastYearDate: let earlyDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
                return earlyDate?.getFormattedDate(format: "yyyy-MM-dd") ?? ""
            }
        }
    }
}

public enum APIRequest: URLRequestConvertible {
    
    case loginUser(username: String, password: String)
    case forgotPassword(username: String)
    case changePassword(otp: Int, username: String, password: String, enc: String)
    case getUserData
    case getSignatoryDetails
    case getBillSlab
    case getNoticeList(pageSize:Int)
    case getComplaintList(pageSize:Int)
    case getNoticeType
    case getComplaintNature
    case getComplaintType
    case getComplaintCategory
    case getMiniStatement(toDate: String, fromDate: String)
    case getAds
    case getBanners
    case getNoticeBoardList
    case uploadFileOnServer
    case addNewNotice(noticeTypeID: String, noticeSubject: String, noticeDescription: String, noticeDate: String, expiryDate: String, attachmentID: Int? = nil)
    case addNewComplaint(natureID: String, complaintTypeID: String, categoryID:String, isUrgent: Bool, description: String, attachmentID: Int? = nil, onBehalfCustomerID: String)
    case makePayment(amount: Int, firstname: String, email: String, phone: String)
    
    var method: HTTPMethod {
        switch self {
        case .getUserData, .getSignatoryDetails, .getBillSlab, .getNoticeList, .getComplaintList, .getNoticeType, .getComplaintNature, .getComplaintType, .getComplaintCategory, .getMiniStatement, .getAds, .getBanners, .getNoticeBoardList:
            return .get
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "token"
        case .forgotPassword:
            return "prelogin/sendptoemail"
        case .changePassword:
            return "prelogin/cp"
        case .getUserData:
            return "business/CustomerDetails?Basic=1"
        case .getSignatoryDetails:
            return "business/WidgetData?Code=DSD"
        case .getBillSlab:
            return "business/WidgetData?Code=DBS"
        case .getNoticeList(let pageSize):
            return "business/NoticeBoard?NoticeTypeID=-1&NoticeSubject=&FromDate=\(Constants.lastYearDate.rawValue)&ToDate=\(Constants.todaysDate.rawValue)&Records=10&PageSize=\(pageSize)"
        case .getComplaintList(let pageSize):
            return "business/ComplaintRegistry?ComplaintNatureID=-1&ComplaintTypeID=-1&CategoryID=-1&FromDate=\(Constants.lastYearDate.rawValue)&ToDate=\(Constants.todaysDate.rawValue)&Records=10&PageSize=\(pageSize)&OnBehalfCustomerID=-1"
        case .getNoticeType:
            return "business/CodeMasterByType?codetype=NoticeType"
        case .getComplaintNature:
            return "business/CodeMasterByType?codetype=ComplaintNature"
        case .getComplaintType:
            return "business/CodeMasterByType?codetype=ComplaintType"
        case .getComplaintCategory:
            return "business/ComplaintCategory"
        case .getMiniStatement(let toDate, let fromDate):
            return "report/GetCustomerReportData?FromDate=\(fromDate)&Report=1&ToDate=\(toDate)&UserID="
        case .getAds:
            return "business/Banners?Type=Ads"
        case .getBanners:
            return "business/Banners?Type=Banner"
        case .getNoticeBoardList:
            return "business/WidgetData?Code=DNB"
        case .uploadFileOnServer:
            return "Upload/abc?keycode=True"
        case .addNewNotice:
            return "business/NoticeBoard"
        case .addNewComplaint:
            return "business/ComplaintRegistry"
        case .makePayment:
            return "payment/requesturl"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .loginUser(let username, let password):
            return ["Username": username,
                    "Password": password]
        case .forgotPassword(let username):
            return ["Username": username]
        case .changePassword(let otp, let password, let username, let enc):
            return ["Username": username,
                    "Password": password,
                    "Enc": enc,
                    "OTP": otp]
        case .addNewNotice(let noticeTypeID, let noticeSubject, let noticeDescription, let noticeDate, let expiryDate, let attachmentID):
            return ["NoticeTypeID": noticeTypeID,
                    "NoticeSubject": noticeSubject,
                    "Description": noticeDescription,
                    "NoticeDate": noticeDate,
                    "ExpiryDate": expiryDate,
                    "AttachmentID": attachmentID,
                    "IsActive": true]
        case.addNewComplaint(let natureID, let complaintTypeID, let categoryID, let isUrgent, let description, let attachmentID, let onBehalfCustomerID):
            return ["NatureID": natureID,
                    "ComplaintTypeID": complaintTypeID,
                    "CategoryID": categoryID,
                    "IsUrgent": isUrgent,
                    "Description": description,
                    "AttachmentID": attachmentID,
                    "OnBehalfCustomerID": onBehalfCustomerID,
                    "IsActive": true
            ]
        case .makePayment(let amount, let firstname, let email, let phone):
            return ["amount": amount,
                    "firstname": firstname,
                    "email": email,
                    "phone": phone,
                    "iagree": true]
        default:
            return [:]
        }
    }
    
    var headers: HTTPHeaders{
        switch self {
        default:
            return UserDefaults.standard.bool(forKey: DefaultKeys.UDUserLoggedIn) ? (["Authorization": Constants.accessToken.rawValue]) : ([:])
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.rawValue.asURL()
        let str = URL(string: url.appendingPathComponent(path).absoluteString.removingPercentEncoding ?? "")
        var request = URLRequest(url: str!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = TimeInterval(10 * 1000)
        print("URL Requested is \(request), Parameters are \(parameters) and Headers are \(headers)")
        switch self{
        case .getUserData, .getSignatoryDetails, .getBillSlab, .getNoticeList, .getComplaintList, .getNoticeType, .getComplaintNature, .getComplaintType, .getComplaintCategory, .getMiniStatement, .getAds, .getBanners, .getNoticeBoardList:
            return try URLEncoding.default.encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
    
}
