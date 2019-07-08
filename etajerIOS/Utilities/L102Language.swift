//
//  Language.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

class LanguageManager{
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: Constants.AppleLanguages.rawValue) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: Constants.AppleLanguages.rawValue)
        userdef.synchronize()
    }
}
