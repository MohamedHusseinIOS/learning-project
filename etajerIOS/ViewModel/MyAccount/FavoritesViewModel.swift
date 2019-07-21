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
        var items: AnyObserver<[Item]>
    }
    
    struct Output {
        var items: Observable<[Item]>
    }
    
    private let items = PublishSubject<[Item]>()
    
    override init() {
        self.input = Input(items: items.asObserver())
        self.output = Output(items: items.asObservable())
        super.init()
        
        items.subscribe { (event) in
            guard let items = event.element else { return }
            print(items)
        }.disposed(by: bag)
    }
    
}
