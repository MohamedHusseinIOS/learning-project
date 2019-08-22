//
//  ItemDetailsViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class ItemDetailsViewModel: BaseViewModel, ViewModelType{
    
    var input: Input
    var output: Output
    
    struct Input {
        var item: AnyObserver<Product>
    }
    
    struct Output {
        var success: Observable<Bool>
        var item: Observable<Product>
        var images: Observable<[ImageModel]>
        var faliure: Observable<[ErrorModel]>
    }
    private let success = PublishSubject<Bool>()
    private let item = PublishSubject<Product>()
    private let images = PublishSubject<[ImageModel]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    private var product: Product?
    
    override init() {
        self.input = Input(item: item.asObserver())
        self.output = Output(success: success.asObserver(),
                             item: item.asObservable(),
                             images: images.asObservable(),
                             faliure: faliure.asObservable())
        super.init()
        item.subscribe {[unowned self] (event) in
            guard let item = event.element else { return }
            self.product = item
        }.disposed(by: bag)
    }
    
    func getProductDetails( id: Int?){
        guard let prodId = id else { return }
        DataManager.shared.getProductDetails(productId: prodId) {[weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                guard let products = value as? Products,
                      let product = products.product,
                      let imgs = product.images else { return }
                self.images.onNext(imgs)
                self.item.onNext(product)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func addToCart(productId: Int, quantity: Int){
        DataManager.shared.addProductToCart(productId: productId, quantity: quantity) { (response) in
            switch response {
            case .success(let value):
                guard let _ = value as? AddToCartResponse else { return}
                self.success.onNext(true)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
}
