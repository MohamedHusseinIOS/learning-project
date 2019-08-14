//
//  CartPageViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CartPageViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        var items: AnyObserver<[CartProduct]>
    }
    
    struct Output {
        var items: Observable<[CartProduct]>
        var faliure: Observable<[ErrorModel]>
        var cart: Observable<Cart>
    }
    
    private var faliure = PublishSubject<[ErrorModel]>()
    private var items = PublishSubject<[CartProduct]>()
    private var cart = PublishSubject<Cart>()
    var dataArray = [CartProduct]()
    
    override init() {
        input = Input(items: items.asObserver())
        output = Output(items: items.asObservable(),
                        faliure: faliure.asObservable(),
                        cart: cart.asObservable())
        super.init()
        cart.bind {[unowned self] (cart) in
            guard let products = cart.products else { return }
            self.dataArray = products
            self.dataArray.append(CartProduct())
            self.items.onNext(self.dataArray)
        }.disposed(by: bag)
    }
    
    func getCartItems(){
        DataManager.shared.getCart {[unowned self] (response) in
            switch response {
            case .success(let value):
                guard let cart = value as? Cart else { return }
                self.cart.onNext(cart)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func removeProductFormCart(productId: Int){
        DataManager.shared.removeProductFromCart(productId: productId) { (response) in
            switch response {
            case .success(let value):
                guard let cart = value as? Cart else { return }
                self.cart.onNext(cart)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
}
