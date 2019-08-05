//
//  ProductDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 8/5/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

extension DataManager {
    
    func getCategories(completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.categories.URL) { (response) in
            self.handelResponseData(response: response, model: Categories.self, completion: completion)
        }
    }
    
    func getProducts(completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.products.URL) { (response) in
            self.handelResponseData(response: response, model: Items.self, completion: completion)
        }
    }
    
    func getProductDetails(productId: Int, completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.productDetails.URL + "id=\(productId)") { (response) in
            self.handelResponseData(response: response, model: Products.self, completion: completion)
        }
    }
}
