//
//  CategoryItemsViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/14/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryItemsViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        var products: AnyObserver<[Product]>
    }
    
    struct Output {
        var products: Observable<[Product]>
        var faliure: Observable<[ErrorModel]>
    }
    
    private let products = PublishSubject<[Product]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    var productsArr = [Product]()
    
    override init() {
        self.input = Input(products: products.asObserver())
        self.output = Output(products: products.asObservable(),
                             faliure: faliure.asObservable())
        super.init()
        
        products.bind(onNext: { (products) in
            self.productsArr = products
        }).disposed(by: bag)
    }
    
    func getProducts(parent: CategoryItemsViewController,categoryId:Int){
        DataManager.shared.getProducts { (response) in
            switch response {
            case .success(let value):
                guard let items = value as? Items,
                      let products = items.items,
                      let caetgories = AppUtility.shared.getAppCategories()?.categories else { return }
                let categoryProducts = self.getProductsFormCategories(products, categories: caetgories, id: categoryId)
                parent.configureItemsCollection()
                self.products.onNext(categoryProducts)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func getProductsFormCategories(_ products: [Product], categories: [Category], id: Int) -> [Product]{
        var productsArr = [Product]()
        guard let category = categories.filter({$0.id == id}).first else { return []}
        category.childs?.forEach({ (sub_category) in
            sub_category.childs?.forEach({ (sub_sub_category) in
                let filteredProducts = products.filter({$0.categoryId == sub_sub_category.id})
                productsArr.append(contentsOf: filteredProducts)
            })
        })
        return productsArr
    }
}

