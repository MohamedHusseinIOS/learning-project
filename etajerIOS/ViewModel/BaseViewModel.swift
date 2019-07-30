//
//  BaseViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    var bag = DisposeBag()
    
    init() {}
    
    func handelApiError(data: Any?, failer: PublishSubject<[ErrorModel]>){
        if let err = data as? ErrorModel{
            failer.onNext([err])
        }else if let errorArr = data as? [ErrorModel]{
            failer.onNext(errorArr)
        }
    }
}
