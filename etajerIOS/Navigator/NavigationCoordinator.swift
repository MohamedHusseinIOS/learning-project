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
    
    private var nvc = UINavigationController()
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
        //SlideMenuOptions.rightViewWidth = 95
        SlideMenuOptions.hideStatusBar = false
        
        guard let homeVC = mainNavigator.makeViewController(for: .homeViewController) else {return}
        guard let slideMenuVC = mainNavigator.makeViewController(for: .sideMenuViewController) else {return}
        nvc.viewControllers.removeAll(keepingCapacity: true)
        if AppUtility.shared.currentLang == .en{
            let slideMenuController = SlideMenuController(mainViewController: homeVC,
                                                      leftMenuViewController: slideMenuVC)
            nvc.viewControllers.append(slideMenuController)
        }else{
            let slideMenuController = SlideMenuController(mainViewController: homeVC,
                                                          rightMenuViewController: slideMenuVC)
            nvc.viewControllers.append(slideMenuController)
        }
        sharedAppDelegate.window?.rootViewController = nvc
        sharedAppDelegate.window?.makeKeyAndVisible()
    }
    
    func reloadTheApp(){
        sideMenuSetup()
        sharedAppDelegate.window?.backgroundColor = Colors.PrimaryColor.value
        UIView.transition( with: (sharedAppDelegate.window)!, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
            //code
        }) { (finished) -> Void in
            //code
        }
    }
    
    func startApp(){
        if AppUtility.shared.currentAccessToken != nil {
            sideMenuSetup()
        } else {
            mainNavigator.navigate(To: .signInViewController)
        }
        sharedAppDelegate.window?.rootViewController = nvc
        sharedAppDelegate.window?.makeKeyAndVisible()
        
    }
}
