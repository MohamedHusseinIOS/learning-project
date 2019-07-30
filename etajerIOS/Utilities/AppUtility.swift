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
    
    enum Environment: String {
        case production = "http://"
        case development = "https://etajer.maxsys.sa"
    }
    
    var currentEnviroment: String {
        guard let env = UserDefaults.standard.value(forKey: Constants.enviroment.rawValue) as? String else { return Environment.development.rawValue }
        guard let envUrl = Environment(rawValue: env)?.rawValue else { return Environment.development.rawValue }
        return envUrl
    }
    
    var currentAccessToken: String? {
        guard let token = UserDefaults.standard.value(forKey: Constants.accessToken.rawValue) as? String else { return nil }
        return token
    }
    
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
    
    func changeEnvironment(_ env: Environment) {
        UserDefaults.standard.set(env.rawValue, forKey: Constants.enviroment.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func saveToken(_ token: String){
        UserDefaults.standard.set(token, forKey: Constants.accessToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func saveCurrentUser(_ user: User){
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do{
            let encodedUser = try? encoder.encode(user)
            UserDefaults.standard.set(encodedUser, forKey: Constants.currentUser.rawValue)
            UserDefaults.standard.synchronize()
        }catch let error {
            print("[saveCurrentUser] \(error.localizedDescription)")
        }
    }
    
    func getCurrentUser() -> User? {
        guard let userData = UserDefaults.standard.object(forKey: Constants.currentUser.rawValue) as? Data else { return nil }
        let decoder = JSONDecoder()
        do{
            let user = try? decoder.decode(User.self, from: userData)
            return user
        } catch let error {
            print("[getCurrentUser] \(error.localizedDescription)")
            return nil
        }
    }
}
