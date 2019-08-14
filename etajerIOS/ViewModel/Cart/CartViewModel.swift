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
        let faliure: Observable<[ErrorModel]>
        let cart: Observable<Cart>
    }

    private let faliure = PublishSubject<[ErrorModel]>()
    private let cart = PublishSubject<Cart>()
    
    override init() {
        input = Input()
        output = Output(faliure: faliure.asObservable(),
                        cart: cart.asObservable())
        super.init()
    }
}
