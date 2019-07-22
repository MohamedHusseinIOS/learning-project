//
//  AddressesViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class AddressesViewModel: BaseViewModel, ViewModelType {
    
    var input: AddressesViewModel.Input
    var output: AddressesViewModel.Output
    
    struct Input {
        var addresses: AnyObserver<[[String: Any]]>
    }
    
    struct Output {
        var addresses: Observable<[[String: Any]]>
    }
    
    private var addresses = PublishSubject<[[String: Any]]>()
    private var dataArray = [[String: Any]]()
    
    override init() {
        self.input = Input(addresses: addresses.asObserver())
        self.output = Output(addresses: addresses.asObservable())
        super.init()
        addresses.subscribe {[unowned self] (event) in
            guard let array = event.element else { return }
            self.dataArray = array
        }.disposed(by: bag)
    }
    
    func removeItem(at index: IndexPath) {
        dataArray.remove(at: index.row)
        addresses.onNext(dataArray)
    }
}
