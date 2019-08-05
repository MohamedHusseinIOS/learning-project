//
//  MenuViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift

class MenuViewModel: BaseViewModel, ViewModelType{
    
    var input: MenuViewModel.Input
    var output: MenuViewModel.Output
    
    struct Input {
        let menuElements: AnyObserver<[Category]>
    }
    
    struct Output {
        let menuElements: Observable<[Category]>
        let faliure: Observable<[ErrorModel]>
    }
    
    private let menuElements = PublishSubject<[Category]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    var categories = [Category]()
    
    override init() {
        input = Input(menuElements: menuElements.asObserver())
        output = Output(menuElements: menuElements.asObservable(),
                        faliure: faliure.asObserver())
        super.init()
        menuElements.bind {[unowned self] (categories) in
            self.categories = categories
        }.disposed(by: bag)
    }
    
    func sendMenuItems(){
        var arr = [MenuElements]()
        for i in 0...10{
            arr.append(MenuElements.element(row: i))
        }
        //menuElements.onNext(arr)
    }
    
    func getCategories(){
        DataManager.shared.getCategories {[unowned self] (response) in
            switch response {
            case .success(let value):
                guard let categoriesRes = value as? Categories,
                      var categories = categoriesRes.categories else { return }
                AppUtility.shared.saveAppCategories(categoriesRes)
                let changeLang = Category(id: nil, name: CHANGE_LANG.localized(), isShipAble: nil, acceptAuction: nil, theIcon: nil, theBanner: nil, childs: nil, products: nil, productsArray: nil)
                categories.append(changeLang)
                self.menuElements.onNext(categories)
            case .failure(_, let data):
                self.handelApiError(data: data, failer: self.faliure)
            }
        }
    }
}
