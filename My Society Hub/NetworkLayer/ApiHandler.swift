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
            }
    }
}
