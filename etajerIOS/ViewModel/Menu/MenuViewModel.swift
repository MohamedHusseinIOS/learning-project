//
//  MenuViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class MenuViewModel: BaseViewModel {
    
    let menuElements = PublishSubject<[MenuElements]>()
    
    override init() {
        super.init()
        
        menuElements.asObserver().subscribe { (event) in
            //Code
        }.disposed(by: bag)
    }
    
    func sendMenuItems(){
        var arr = [MenuElements]()
        for i in 0...9{
            arr.append(MenuElements.element(row: i))
        }
        menuElements.onNext(arr)
    }
}
