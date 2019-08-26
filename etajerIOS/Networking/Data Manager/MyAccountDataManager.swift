//
//  MyAccountDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 8/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

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
    
}
