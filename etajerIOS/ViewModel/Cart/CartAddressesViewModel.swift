//
//  CartAddressesViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/24/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class CartAddressesViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        var addresses: AnyObserver<[[String: Any]]>
    }
    
    struct Output {
        var addresses: Observable<[[String: Any]]>
    }
    
    private var addresses = PublishSubject<[[String: Any]]>()
    var dataArray = [[String: Any]]()
    
    override init() {
        input = Input(addresses: addresses.asObserver())
        output = Output(addresses: addresses.asObservable())
        super.init()
        addresses.bind {[unowned self] (items) in
            self.dataArray = items
        }.disposed(by: bag)
    }
    
    func removeItem(at index: IndexPath) {
        dataArray.remove(at: index.row)
        addresses.onNext(dataArray)
    }
}
