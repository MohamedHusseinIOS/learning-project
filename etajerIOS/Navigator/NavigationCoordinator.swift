//
//  NavigationCoordinator.swift
//  NavigatorDemo
//
//  Created by Mohamed Hussien on 17/04/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit
import SlideMenuControllerSwift

class NavigationCoordinator{
    
    static let shared = NavigationCoordinator()
    
    private let nvc = UINavigationController()
    private var childNVC: UINavigationController!
    
    private let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var mainNavigator: MainNavigator!
    var childNavigator: MainNavigator?
    
    var parentViewController: BaseViewController?
    
    private init() {
        mainNavigator = MainNavigator(navigationController: nvc)
    }
    
    func addChildNVC(_ childNVC: UINavigationController, parentViewController: BaseViewController){
        self.parentViewController = parentViewController
        self.childNVC = childNVC
        childNavigator = MainNavigator(navigationController: self.childNVC)
    }
    
    func sideMenuSetup(){
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.panGesturesEnabled = false
        SlideMenuOptions.rightViewWidth = 95
        SlideMenuOptions.hideStatusBar = false
        
        guard let homeVC = mainNavigator.makeViewController(for: .homeViewController) else {return}
        guard let slideMenuVC = mainNavigator.makeViewController(for: .sideMenuViewController) else {return}
        let slideMenuController = SlideMenuController(mainViewController: homeVC, rightMenuViewController: slideMenuVC)
        
        sharedAppDelegate.window?.rootViewController = slideMenuController
        sharedAppDelegate.window?.makeKeyAndVisible()
    }
    
    func startApp(){
        mainNavigator.navigate(To: .signInViewController)
        sharedAppDelegate.window?.rootViewController = nvc
        sharedAppDelegate.window?.makeKeyAndVisible()
    }
}
