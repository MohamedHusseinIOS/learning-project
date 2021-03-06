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
        var cart: Observable<CartResponse>
    }
    
    private var faliure = PublishSubject<[ErrorModel]>()
    private var items = PublishSubject<[CartProduct]>()
    private var cart = PublishSubject<CartResponse>()
    private var addToCartRes = PublishSubject<AddToCartResponse>()
    var dataArray = [CartProduct]()
    
    override init() {
        input = Input(items: items.asObserver())
        output = Output(items: items.asObservable(),
                        faliure: faliure.asObservable(),
                        cart: cart.asObservable())
        super.init()
        cart.bind {[unowned self] (cartRes) in
            guard let products = cartRes.cart?.products else { return }
            self.handleCartRes(products: products)
        }.disposed(by: bag)
        
        addToCartRes.bind {[unowned self] (addToCartRes) in
            guard let products = addToCartRes.cart?.products else { return }
            self.handleCartRes(products: products)
        }.disposed(by: bag)
    }
    
    func handleCartRes(products: [CartProduct]){
        self.dataArray = products
        self.dataArray.append(CartProduct())
        self.items.onNext(self.dataArray)
    }
    
    func getCartItems(){
        DataManager.shared.getCart {[unowned self] (response) in
            switch response {
            case .success(let value):
                guard let cartRes = value as? CartResponse else { return }
                self.cart.onNext(cartRes)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func changeQuitity(ofProduct productId: Int?, by qty: Int?) {
        DataManager.shared.addProductToCart(productId: productId, quantity: qty) { (response) in
            switch response {
            case .success(let value):
                guard let addToCartRes = value as? AddToCartResponse else { return }
                self.addToCartRes.onNext(addToCartRes)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func removeProductFormCart(productId: Int){
        DataManager.shared.removeProductFromCart(productId: productId) { (response) in
            switch response {
            case .success(let value):
                guard let addToCartRes = value as? AddToCartResponse else { return }
                self.addToCartRes.onNext(addToCartRes)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
}
