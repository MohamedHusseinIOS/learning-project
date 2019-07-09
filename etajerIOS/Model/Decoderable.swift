//
//  Decoder.swift
//  etajerIOS
//
//  Created by mohamed on 7/9/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation


protocol Decoderable {
    func decodeJSON<T: Codable>(_ json: Any, To model: T, format: JSONDecoder.KeyDecodingStrategy) -> T
}

extension Decoderable where Self : Codable {
    func decodeJSON<T:Codable>(_ json: Any, To model: T, format: JSONDecoder.KeyDecodingStrategy, isObject: Bool) -> Any?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = format
        do {
            guard let jsonData = Data.convertToData(json) else{return nil}
            let jsonDecoder = JSONDecoder()
            var result: Any?
            if isObject {
                let object = try jsonDecoder.decode(T.self, from: jsonData)
                result = object
            } else {
                let list = try jsonDecoder.decode([T].self, from: jsonData)
                result = list
            }
            return result
        } catch let _error {
            debugPrint(_error.localizedDescription)
            return nil
        }
    }
}
