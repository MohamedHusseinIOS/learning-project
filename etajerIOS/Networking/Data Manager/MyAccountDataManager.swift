//
//  MyAccountDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 8/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

extension DataManager {
    
    func getNotification(completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.getNotifications.URL) { (response) in
            self.handelResponseData(response: response, model: NotificationResponse.self, completion: completion)
        }
    }
}
