//
//  NetworkManager.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseEnum {
    case failure(error: ApiError?)
    case success(value: Any?)
}

enum ApiError: Int {
    case BadRequest = 400
    case ServerError = 500
    case ClientSideError = 0
    
    var message: String{
        switch self {
        case .BadRequest:
            return "Bad request"
        case .ServerError:
            return "Internal Server Error"
        case .ClientSideError:
            return "ClientSide Error"
    }
}

class NetworkManager {
    
    let shared = NetworkManager()
    private init(){}
    typealias responseCallback = ((ResponseEnum) -> Void)
    
    private var headers: HTTPHeaders {
        guard let token = UserDefaults.standard.value(forKey: Constants.token.rawValue) as? String else { return [:] }
        let headerDict = [
            "Authorization":"Bearer\(token)",
            "Accept-Language": AppUtility.shared.currentLang.rawValue
        ]
        return headerDict
    }
    
    
    func get(url: String, paramters: Parameters? = nil, completion: @escaping responseCallback){
        
        Alamofire.request(url, method: .get, parameters: paramters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            guard let code = response.response?.statusCode else {
                completion(.failure(error: ApiError.ClientSideError))
                return
            }
            
            if code < 400, let res = response.value as? Parameters{
                completion(.success(value: res))
            } else {
                completion(.failure(error: ApiError(rawValue: code)))
            }
        }
    }
    
    func post(url: String, paramters: Parameters?, completion: @escaping responseCallback){
        
        Alamofire.request(url, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let code = response.response?.statusCode
            
            if code < 400, let res = response.value as? Parameters{
                completion(.success(value: res))
            } else {
                completion(.failure(error: ApiError(rawValue: code)))
            }
        }
    }
    
    
}
