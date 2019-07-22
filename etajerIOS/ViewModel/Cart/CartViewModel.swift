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
        var items: AnyObserver<[Item]>
    }
    
    struct Output {
        var items: Observable<[Item]>
    }
    
    private var items = PublishSubject<[Item]>()
    private var dataArray = [Item]()
    
    override init() {
        input = Input(items: items.asObserver())
        output = Output(items: items.asObservable())
        super.init()
        items.bind {[unowned self] (items) in
            self.dataArray = items
        }.disposed(by: bag)
        
    }
    
    func removeItem(at index: IndexPath) {
        dataArray.remove(at: index.row)
        items.onNext(dataArray)
    }
}
