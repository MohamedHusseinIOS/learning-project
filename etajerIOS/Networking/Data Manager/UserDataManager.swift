//
//  File.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import SVProgressHUD

extension DataManager {
    
    func login(email: String, password: String, completion: @escaping NetworkManager.responseCallback) {
        
        let params = ["identity": email,
                      "password": password] as [String: Any]
        SVProgressHUD.show()
        NetworkManager.shared.post(url: URLs.login.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
    
    func signup(email: String, password: String, firstName: String, lastName: String, mobile: String, completion: @escaping NetworkManager.responseCallback) {
        
        let params: [String: Any] = ["email": email,
                                     "mobile": mobile,
                                     "first_name": firstName,
                                     "last_name": lastName,
                                     "password": password,
                                     "password_confirm": password]
        SVProgressHUD.show()
        NetworkManager.shared.post(url: URLs.signup.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
    
    func requestResetPassword(email: String, completion: @escaping NetworkManager.responseCallback) {
        
        let params: [String: Any] = ["email": email]
        SVProgressHUD.show()
        NetworkManager.shared.post(url: URLs.requestResetPassword.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
    
    func getCurrentUser(completion: @escaping NetworkManager.responseCallback){
        SVProgressHUD.show()
        NetworkManager.shared.get(url: URLs.currentUser.URL) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: User.self, completion: completion)
        }
    }
    
    func logout(completion: @escaping NetworkManager.responseCallback) {
        SVProgressHUD.show()
        NetworkManager.shared.post(url: URLs.logout.URL, paramters: nil) { (response) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let value):
                break
            case .failure(let error, let data):
                completion(.failure(error, data))
            }
        }
    }
}
