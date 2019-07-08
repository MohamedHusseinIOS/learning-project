//
//  Bundle+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/8/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

extension Bundle {
    
    @objc func specialLocalizedString(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LanguageManager.shared.currentAppleLanguage()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return (bundle.specialLocalizedString(key: key, value: value, table: tableName))
    }
}
