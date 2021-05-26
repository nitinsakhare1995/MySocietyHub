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
    
    func getUserData(completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getUserData)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<UserModel>().map(JSONObject: response.result.value)
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
    
    func getSignatoryDetails(completion: @escaping (SignatoryModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getSignatoryDetails)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<SignatoryModel>().map(JSONObject: response.result.value)
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
    
    func getBillSlab(completion: @escaping (SignatoryModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getBillSlab)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<SignatoryModel>().map(JSONObject: response.result.value)
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
    
    func getNoticeList(pageSize: Int, completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getNoticeList(pageSize: pageSize))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
    
    func getComplaintList(pageSize: Int, completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getComplaintList(pageSize: pageSize))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
    
    func getNoticeType(completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getNoticeType)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
    
    func getComplaintNature(completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getComplaintNature)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
    
    func getComplaintType(completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getComplaintType)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
    
    func getComplaintCategory(completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getComplaintCategory)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<NoticeModel>().map(JSONObject: response.result.value)
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
