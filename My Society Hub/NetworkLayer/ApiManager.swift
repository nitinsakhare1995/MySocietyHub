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
    
    var method: HTTPMethod {
        switch self {
        case .getUserData, .getSignatoryDetails, .getBillSlab, .getNoticeList, .getComplaintList:
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
        case .getUserData, .getSignatoryDetails, .getBillSlab, .getNoticeList, .getComplaintList:
            return try URLEncoding.default.encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
    
}
