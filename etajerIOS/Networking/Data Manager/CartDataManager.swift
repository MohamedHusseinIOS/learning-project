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
    
    func addProductToCart(productId: Int?, quantity: Int?, completion: @escaping NetworkManager.responseCallback) {
        
        guard let id = productId else { return }
        guard let qty = quantity else { return }
        let params: [String: Any] = ["product_id": id,
                                     "qty":qty]
        SVProgressHUD.show()
        NetworkManager.shared.post(url: URLs.addToCart.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: AddToCartResponse.self, completion: completion)
        }
    }
    
    func removeProductFromCart(productId: Int?, completion: @escaping NetworkManager.responseCallback) {
        
        guard let id = productId else { return }
        let params: [String: Any] = ["product_id": id]
        
        NetworkManager.shared.post(url: URLs.removeFormCart.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: AddToCartResponse.self, completion: completion)
        }
    }
    
    func getAddresses(completion: @escaping NetworkManager.responseCallback) {
        NetworkManager.shared.get(url: URLs.getAddresses.URL) { (response) in
            self.handelResponseData(response: response, model: Addresses.self, completion: completion)
        }
    }
    
    func setNewAddress(name: String, country: String, city: String, area: String, street: String, building: String, mobile: String, completion: @escaping NetworkManager.responseCallback) {
        
        let params: [String: Any] = ["name": name,
                                     "country": country,
                                     "city":city,
                                     "area":area,
                                     "street":street,
                                     "building":building,
                                     "mobile":mobile]
        
        NetworkManager.shared.post(url: URLs.newAddress.URL, paramters: params) { (response) in
            SVProgressHUD.dismiss()
            self.handelResponseData(response: response, model: AddressResponse.self, completion: completion)
        }
        
    }
}


