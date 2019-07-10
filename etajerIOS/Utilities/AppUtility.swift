//
//  AppUtility.swift
//  Fundaqah
//
//  Created by mohamed on 7/1/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {
    
    static let shared = AppUtility()
    
    let interface = UIDevice.current.userInterfaceIdiom
    let orientation = UIDevice.current.orientation
    var currentLang: AppLanguages{
        return LanguageManager.shared.currentAppleLanguage()
    }
    
    var bounds = UIScreen.main.bounds
    var screenWidth = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    
    private init() {}
    
    func changeLanguage(){
        switch LanguageManager.shared.currentAppleLanguage() {
        case .en:
            LanguageManager.shared.setAppleLAnguageTo(lang: .ar)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        case .ar:
            LanguageManager.shared.setAppleLAnguageTo(lang: .en)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        NavigationCoordinator.shared.reloadTheApp()
    }
    
    func changeLanguage(to lang: AppLanguages){
        let isArabic = lang == .ar
        LanguageManager.shared.setAppleLAnguageTo(lang: lang)
        UIView.appearance().semanticContentAttribute = isArabic ? .forceRightToLeft : .forceLeftToRight
        NavigationCoordinator.shared.reloadTheApp()
    }
    
}
