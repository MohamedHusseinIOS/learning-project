//
//  FilterViewModel.swift
//  etajerIOS
//
//  Created by mohamed on 8/6/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class FilterViewModel: BaseViewModel, ViewModelType {
    
    let input: FilterViewModel.Input
    let output: FilterViewModel.Output
    
    struct Input {
        let data: AnyObserver<[SectionModel<String, Category>]>
    }
    
    struct Output {
        let data: Observable<[SectionModel<String, Category>]>
        let faliure: Observable<[ErrorModel]>
    }
    
    private let data = PublishSubject<[SectionModel<String, Category>]>()
    private let faliure = PublishSubject<[ErrorModel]>()
    private var category: Category?
    
    let sections = [PRODUCT_FILTERATION.localized(),
                    PRODUCT_TYBE.localized(),
                    PRODUCT_CONDITION.localized()]
    
    override init() {
        input = Input(data: data.asObserver())
        output = Output(data: data.asObservable(),
                        faliure: faliure.asObservable())
        super.init()
    }
    
    func getSubCategoryForm(category: Category?){
        var dataArr = [SectionModel<String, Category>]()
        guard let subCategories = category?.childs else { return }
        self.sections.forEach { (sectionName) in
            switch sectionName {
            case PRODUCT_FILTERATION.localized():
                var categoryProduct = Category()
                categoryProduct.name = PRODUCTS.localized()
                var categoryAuction = Category()
                categoryAuction.name = CATEGORY_TITLE_2.localized()
                let categories = [categoryProduct, categoryAuction]
                dataArr.append(SectionModel(model: sectionName, items: categories))
            case PRODUCT_TYBE.localized():
                dataArr.append(SectionModel(model: sectionName, items: subCategories))
            case PRODUCT_CONDITION.localized():
                var categoryNew = Category()
                categoryNew.name = NEW.localized()
                var categoryUsed = Category()
                categoryUsed.name = USED.localized()
                let categories = [categoryNew, categoryUsed]
                dataArr.append(SectionModel(model: sectionName, items: categories))
            default:
                break
            }
        }
        data.onNext(dataArr)
    }
}
