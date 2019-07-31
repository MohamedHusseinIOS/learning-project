//
//  HomeDataManager.swift
//  etajerIOS
//
//  Created by mohamed on 7/31/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

extension DataManager {
    
    func gethomePage(completion: @escaping NetworkManager.responseCallback){
        NetworkManager.shared.get(url: URLs.categories.URL) { (response) in
            self.handelResponseData(response: response, model: HomeResponse(), completion: completion)
        }
    }
    
    
    
}
