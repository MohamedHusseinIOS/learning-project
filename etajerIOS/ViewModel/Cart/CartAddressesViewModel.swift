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
        var addresses: AnyObserver<[Address]>
    }
    
    struct Output {
        var faliure: Observable<[ErrorModel]>
        var addresses: Observable<[Address]>
    }
    private var faliure = PublishSubject<[ErrorModel]>()
    private var addresses = PublishSubject<[Address]>()
    private var addressesResponse = PublishSubject<[Address]>()
    var dataArray = [Address]()
    
    override init() {
        input = Input(addresses: addresses.asObserver())
        output = Output(faliure: faliure.asObservable(),
                        addresses: addresses.asObservable())
        super.init()
        addressesResponse.bind { [unowned self] (items) in
            self.dataArray = items
            self.dataArray.append(Address())
            self.addresses.onNext(self.dataArray)
        }.disposed(by: bag)
    }
    
    func getAddresses(){
        DataManager.shared.getAddresses { [unowned self] (response) in
            switch response {
            case .success(let value):
                guard let addresses = value as? Addresses else { return }
                self.addressesResponse.onNext(addresses.addresses)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
    
    func removeItem(at index: IndexPath) {
        dataArray.remove(at: index.row)
        addresses.onNext(dataArray)
    }
}
