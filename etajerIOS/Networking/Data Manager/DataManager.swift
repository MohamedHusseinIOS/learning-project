//
//  DataManager.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import SVProgressHUD

class DataManager {
    
    static let shared = DataManager()
    private init(){}
    
    func handelResponseData<T: BaseModel>( response: ResponseEnum, model: T.Type, completion: @escaping NetworkManager.responseCallback){
        switch response {
        case .success(let value):
            guard let value = value else { return }
            let responseData = model.decodeJSON(value, To: model, format: .convertFromSnakeCase)
            completion(.success(responseData))
        case .failure(let error, let data):
            completion(.failure(error, data))
        }
    }
}
