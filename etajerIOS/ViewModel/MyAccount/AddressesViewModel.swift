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
        var addresses: AnyObserver<[Address]>
    }
    
    struct Output {
        var addresses: Observable<[Address]>
        var faliure: Observable<[ErrorModel]>
    }
    
    private var faliure = PublishSubject<[ErrorModel]>()
    private var addresses = PublishSubject<[Address]>()
    private var addressesResponse = PublishSubject<[Address]>()
    private var dataArray = [Address]()
    
    override init() {
        self.input = Input(addresses: addresses.asObserver())
        self.output = Output(addresses: addresses.asObservable(),
                             faliure: faliure.asObservable())
        super.init()
        addressesResponse.subscribe {[unowned self] (event) in
            guard let array = event.element else { return }
            self.dataArray = array
            self.addresses.onNext(array)
        }.disposed(by: bag)
    }
    
    func getAddresses(parent: AddressesViewController){
        DataManager.shared.getAddresses { [unowned self] (response) in
            switch response {
            case .success(let value):
                guard let addresses = value as? Addresses else { return }
                parent.configureTableView()
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
