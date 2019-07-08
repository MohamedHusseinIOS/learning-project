//
//  Language.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

class LanguageManager{
    
    static let shared = LanguageManager()
    
    private init() {}
    
    /// get current Apple language
    func currentAppleLanguage() -> AppLanguages{
        let userdef = UserDefaults.standard
        guard let langArray = userdef.object(forKey: Constants.AppleLanguages.rawValue) as? Array<String> else{return .en}
        guard let current = langArray.first else{return .en}
        guard let currentLang = AppLanguages(rawValue: current) else{return .en}
        return currentLang
    }
    
    /// set @lang to be the first in Applelanguages list
    func setAppleLAnguageTo(lang: AppLanguages) {
        let userdef = UserDefaults.standard
        userdef.set([lang.rawValue,currentAppleLanguage().rawValue], forKey: Constants.AppleLanguages.rawValue)
        userdef.synchronize()
    }
    
    func DoTheSwizzling() {
        // 1
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedString(key:value:table:)))
    }
    
    private func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
        guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector) else {return}
        guard let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else{return}
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
    
}
