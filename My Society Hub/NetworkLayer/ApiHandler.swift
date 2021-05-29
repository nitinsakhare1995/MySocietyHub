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
    
    func getMiniStatement(toDate: String, fromDate: String, completion: @escaping (MiniStatementModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getMiniStatement(toDate: toDate, fromDate: fromDate))
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    SVProgressHUD.dismiss()
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil{
                            print(response.result.value!)
                            let apiResponse = Mapper<MiniStatementModel>().map(JSONObject: response.result.value)
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
    
    func getAds(completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getAds)
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
    
    func getBanners(completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getBanners)
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
    
    func getNoticeBoardList(completion: @escaping (NoticeModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getNoticeBoardList)
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
    
    func uploadFileOnServer(image: UIImage, completion: @escaping (LoginModel?) -> Void){
        
        let url = AppSettings.baseUrl + APIRequest.uploadFileOnServer.path
        let imageData = image.jpegData(compressionQuality: 1)
        let headers: HTTPHeaders = ["Authorization": Constants.accessToken.rawValue]
        SVProgressHUD.show()
        guard let imgData = imageData else { return }
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "UploadedImage",fileName: "file.jpg", mimeType: "image/jpg")
            
        },
        to: url, method:.post,
        headers:headers)
        { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    SVProgressHUD.dismiss()
                    if response.result.value != nil{
                        print(response.result.value!)
                        let apiResponse = Mapper<LoginModel>().map(JSONObject: response.result.value)
                        completion(apiResponse)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                
            }
        }
    }
    
    func addNewNotice(noticeTypeID: String, noticeSubject: String, noticeDescription: String, noticeDate: String, expiryDate: String, attachmentID: Int? = nil, completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.addNewNotice(noticeTypeID: noticeTypeID, noticeSubject: noticeSubject, noticeDescription: noticeDescription, noticeDate: noticeDate, expiryDate: expiryDate, attachmentID: attachmentID))
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
    
    func addNewComplaint(natureID: String, complaintTypeID: String, categoryID: String, isUrgent: Bool, description: String, attachmentID: Int? = nil, onBehalfCustomerID: String, completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.addNewComplaint(natureID: natureID, complaintTypeID: complaintTypeID, categoryID: categoryID, isUrgent: isUrgent, description: description, attachmentID: attachmentID, onBehalfCustomerID: onBehalfCustomerID))
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
    
    func makePayment(amount: Int, firstname: String, email: String, phone: String, completion: @escaping (UserModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.makePayment(amount: amount, firstname: firstname, email: email, phone: phone))
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
    
    func getDocumentUrl(type: String, Id: String, completion: @escaping (LoginModel?) -> Void){
        SVProgressHUD.show()
        Alamofire.request(APIRequest.getDocumentUrl(type: type, Id: Id))
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
    
}
