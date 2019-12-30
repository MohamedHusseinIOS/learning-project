//
//  AuctionDetailsViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class AuctionDetailsViewModel: BaseViewModel, ViewModelType{
    
    var input: Input
    var output: Output
    
    struct Input {
        var item: AnyObserver<Product>
    }
    
    struct Output {
        var item: Observable<Product>
        var images: Observable<[ImageModel]>
        var faliure: Observable<[ErrorModel]>
    }
    
    private let item = PublishSubject<Product>()
    private let images = PublishSubject<[ImageModel]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    private var product: Product?
    
    override init() {
        self.input = Input(item: item.asObserver())
        self.output = Output(item: item.asObservable(),
                             images: images.asObservable(),
                             faliure: faliure.asObservable())
        super.init()
        
        item.bind(onNext:{[unowned self] (product) in
            self.product = product
        }).disposed(by: bag)
    }
    
    func getProductDetails( id: Int?){
        guard let prodId = id else { return }
        DataManager.shared.getProductDetails(productId: prodId) {[unowned self] (response) in
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
}
