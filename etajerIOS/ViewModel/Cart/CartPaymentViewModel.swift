//
//  CartPaymentViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class CartPaymentViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {
        var data: AnyObserver<[SectionModel<String, [String: Any?]>]>
    }
    
    struct Output {
        var data: Observable<[SectionModel<String, [String: Any?]>]>
    }
    
    private var data = PublishSubject<[SectionModel<String, [String: Any?]>]>()
    var dataArray = [SectionModel<String, [String: Any?]>]()
    
    override init() {
        input = Input(data: data.asObserver())
        output = Output(data: data.asObservable())
        super.init()
        data.bind {[unowned self] (items) in
            self.dataArray = items
        }.disposed(by: bag)
    }
}
