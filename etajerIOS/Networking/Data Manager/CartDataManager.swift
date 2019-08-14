//
//  CartDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 8/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import SVProgressHUD


extension DataManager {
    
    func getCart(completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getCart.URL) { (response) in
            self.handelResponseData(response: response, model: CartResponse.self, completion: completion)
        }
    }
    
    func addProductToCart(productId: Int?, completion: @escaping NetworkManager.responseCallback) {
        
        guard let id = productId else { return }
        let params: [String: Any] = ["product_id": id]
        
        NetworkManager.shared.post(url: URLs.addToCart.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: CartResponse.self, completion: completion)
        }
    }
    
    func removeProductFromCart(productId: Int?, completion: @escaping NetworkManager.responseCallback) {
        
        guard let id = productId else { return }
        let params: [String: Any] = ["product_id": id]
        
        NetworkManager.shared.post(url: URLs.removeFormCart.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: CartResponse.self, completion: completion)
        }
    }
}


