//
//  FavoritesViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/18/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class FavoritesViewModel: BaseViewModel, ViewModelType {

    var input: Input
    var output: Output
    
    struct Input {
        var items: AnyObserver<[Product]>
    }
    
    struct Output {
        var faliure: Observable<[ErrorModel]>
        var items: Observable<[Product]>
        var stores: Observable<[Store]>
    }
    private let faliure = PublishSubject<[ErrorModel]>()
    private let items = PublishSubject<[Product]>()
    private let stores = PublishSubject<[Store]>()
    
    var pageNum = 1
    var storesPageNum = 1
    var pastLastIndex = 0
    var storesPastLastIndex = 0
    var itemsArr = [Product]()
    var newPageItems = [Product]()
    var storesArr = [Store]()
    var newPageStores = [Store]()
    
    override init() {
        self.input = Input(items: items.asObserver())
        
        self.output = Output(faliure: faliure.asObservable(),
                             items: items.asObservable(),
                             stores: stores.asObservable())
        super.init()
        
        items.subscribe { [unowned self] (event) in
            guard let items = event.element else { return }
            self.handleNewPage(items: items)
        }.disposed(by: bag)
    }
    
    func handleNewPage(items: [Product]){
        newPageItems = items
        pastLastIndex = self.itemsArr.count - 1
        self.itemsArr.append(contentsOf: items)
        pageNum += 1
    }
    
    func handelStoresNewPage(stores: [Store]) {
        newPageStores = stores
        storesPastLastIndex = self.storesArr.count - 1
        self.storesArr.append(contentsOf: stores)
        storesPageNum += 1
    }
    
    func getFavoriteProducts(){
        DataManager.shared.getFavoritesProducts(page: pageNum) { (response) in
            switch response {
            case .success(let value):
                guard let res = value as? FavoriteProductsResponse, let favoProducts = res.products else { return }
                self.items.onNext(favoProducts)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func getFavoriteStores(){
        DataManager.shared.getFavoritesStores(page: storesPageNum) { (response) in
            switch response {
            case .success(let value):
                guard let res = value as? FavoriteStoresResponse, let favoStores = res.stores else { return }
                self.stores.onNext(favoStores)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
}
