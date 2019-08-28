//
//  MyAccountDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 8/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import SVProgressHUD

extension DataManager {
    
    func getMyOrders(page: Int, completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getMyOrders.URL + "?page=\(page)") { (response) in
            self.handelResponseData(response: response, model: MyOrdersResponse.self, completion: completion)
        }
    }
    
    func getNotification(page: Int, completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getNotifications.URL + "?page=\(page)") { (response) in
            self.handelResponseData(response: response, model: NotificationResponse.self, completion: completion)
        }
    }
    
    func getFavoritesProducts(page: Int, completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getFavoritesProduct.URL + "?page=\(page)") { (response) in
            self.handelResponseData(response: response, model: FavoriteProductsResponse.self, completion: completion)
        }
    }
    
    func getFavoritesStores(page: Int, completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getFavoritesStores.URL + "?page=\(page)") { (response) in
            self.handelResponseData(response: response, model: NotificationResponse.self, completion: completion)
        }
    }
    
    func changeUserData(firstName: String, lastName: String, email: String, mobile: String, completion: @escaping NetworkManager.responseCallback){
        SVProgressHUD.show()
        let params: [String: Any] = ["first_name": firstName,
                                     "last_name": lastName,
                                     "email": email,
                                     "mobile": mobile]
        NetworkManager.shared.post(url: URLs.changeUserData.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
    
    func changePassword(newPassword: String, confirmPassword: String, completion: @escaping NetworkManager.responseCallback) {
        SVProgressHUD.show()
        let params: [String: Any] = ["password": newPassword,
                                     "password_confirm": confirmPassword]
        NetworkManager.shared.post(url: URLs.changePassword.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
    
    func changeUserBankInfo(holderName: String, iban: String, bankName: String, completion: @escaping NetworkManager.responseCallback){
        let params: [String: Any] = ["bank_holdername": holderName,
                                     "bank_iban": iban,
                                     "bank_name": bankName]
        NetworkManager.shared.post(url: URLs.changeUserData.URL, paramters: params) { (response) in
            self.handelResponseData(response: response, model: SignInUpResponse.self, completion: completion)
        }
    }
}
