//
//  CartViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class CartViewModel: BaseViewModel, ViewModelType {
    
    var input: CartViewModel.Input
    var output: CartViewModel.Output
    
    struct Input {
        
    }
    
    struct Output {
        
    }

    override init() {
        input = Input()
        output = Output()
        super.init()
    }

}
