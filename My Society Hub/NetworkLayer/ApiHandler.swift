//
//  ApiHandler.swift
//  My Society Hub
//
//  Created by Nitin Sakhare on 25/05/21.
//

import Foundation
import Alamofire
import ObjectMapper
import SVProgressHUD

class Remote {
    
    static let shared = Remote()
    private init() {}
    
    func loginUser(username: String, password: String, completion: @escaping (LoginModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.loginUser(username: username, password: password))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<LoginModel>().map(JSONObject: response.result.value)
                            completion(apiResponse)
                        }
                        break
                    case .failure(_):
                        showSnackBar(with: LocalizedString.apiError, duration: .middle)
                        print(response.result.error!)
                        break
                    }
                }else{
                    showSnackBar(with: LocalizedString.apiError, duration: .middle)
                    SVProgressHUD.dismiss()
                }
            }
        
    }
    
    func forgotPassword(username: String, completion: @escaping (PasswordModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.forgotPassword(username: username))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<PasswordModel>().map(JSONObject: response.result.value)
                            completion(apiResponse)
                        }
                        break
                    case .failure(_):
                        showSnackBar(with: LocalizedString.apiError, duration: .middle)
                        print(response.result.error!)
                        break
                    }
                }else{
                    showSnackBar(with: LocalizedString.apiError, duration: .middle)
                    SVProgressHUD.dismiss()
                }
            }
        
    }
    
    func changePassword(otp: Int, username: String, password: String, enc: String, completion: @escaping (PasswordTableModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.changePassword(otp: otp, username: username, password: password, enc: enc))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<PasswordTableModel>().map(JSONObject: response.result.value)
                            completion(apiResponse)
                        }
                        break
                    case .failure(_):
                        showSnackBar(with: LocalizedString.apiError, duration: .middle)
                        print(response.result.error!)
                        break
                    }
                }else{
                    showSnackBar(with: LocalizedString.apiError, duration: .middle)
                    SVProgressHUD.dismiss()
                }
            }
        
    }
    
}
