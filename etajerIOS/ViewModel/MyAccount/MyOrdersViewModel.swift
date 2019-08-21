//
//  MyOrderViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 8/21/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class MyOrdersViewModel: BaseViewModel, ViewModelType {
    
    var input: Input
    var output: Output
    
    struct Input {}
    
    struct Output {
        var myOrders: Observable<[Order]>
        var failure: Observable<[ErrorModel]>
    }
    
    private let myOrders = PublishSubject<[Order]>()
    private let failure = PublishSubject<[ErrorModel]>()
    
    var pageNum = 1
    var pastLastIndex = 0
    var orders = [Order]()
    var newPageOrders = [Order]()
    
    override init() {
        self.input = Input()
        self.output = Output(myOrders: myOrders.asObservable(),
                             failure: failure.asObservable())
        super.init()
        myOrders.bind { [unowned self] (orders) in
            self.handleNewPage(orders: orders)
        }.disposed(by: bag)
    }
    
    func handleNewPage(orders: [Order]){
        self.newPageOrders = orders
        pastLastIndex = self.orders.count - 1
        self.orders.append(contentsOf: orders)
        self.pageNum += 1
    }
    
    func getMyOrders(){
        DataManager.shared.getMyOrders(page: pageNum) { [unowned self] (response) in
            switch response {
            case .success(let value):
                guard let ordersRes = value as? MyOrdersResponse, let orders = ordersRes.orders else { return }
                self.myOrders.onNext(orders)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.failure)
            }
        }
    }
}
