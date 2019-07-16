//
//  ItemDetailsViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/16/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class ItemDetailsViewModel: BaseViewModel, ViewModelType{
    
    var input: Input
    var output: Output
    
    struct Input {
        var item: AnyObserver<Item>
    }
    
    struct Output {
        var item: Observable<Item>
        var images: Observable<[UIImage]>
    }
    
    private let item = PublishSubject<Item>()
    private let images = PublishSubject<[UIImage]>()
    
    override init() {
        self.input = Input(item: item.asObserver())
        self.output = Output(item: item.asObservable(),
                             images: images.asObservable())
        super.init()
        
        item.subscribe {[unowned self] (event) in
            guard let item = event.element else { return }
            guard let images = item.images else { return }
            self.images.onNext(images)
        }.disposed(by: bag)
    }
}
