//
//  ViewModelType.swift
//  etajerIOS
//
//  Created by mohamed on 7/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
