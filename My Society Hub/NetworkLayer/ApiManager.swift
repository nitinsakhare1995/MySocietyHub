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
    
    var rawValue: String {
        get {
            switch self {
            case .baseURLPath: return AppSettings.baseUrl
            case .accessToken: return "Bearer " + (UserDefaults.standard.string(forKey: DefaultKeys.UDAccessToken) ?? "")
            }
        }
    }
}

public enum APIRequest: URLRequestConvertible {
    
    case loginUser(username: String, password: String)
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "token"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .loginUser(let username, let password):
            return ["Username": username,
                    "Password": password]
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
        //        switch self{
        //        case .getUsersList, .getUserProfile, .getUserPermissionList:
        //            return try URLEncoding.default.encode(request, with: parameters)
        //        default:
        return try JSONEncoding.default.encode(request, with: parameters)
        //        }
    }
    
}
