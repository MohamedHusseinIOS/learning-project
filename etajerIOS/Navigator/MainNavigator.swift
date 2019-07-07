//
//  MainNavigator.swift
//  NavigatorDemo
//
//  Created by Mohamed Hussien on 17/04/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit

//MARK:- storyboards
enum storyboards: String {
    case main = "Main"
    case menu = "Menu"
    case signIn = "SignIn"
    
    var instanse: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
}

class MainNavigator{
    
    private weak var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension MainNavigator: Navigator{
    //MARK:- Destination
    enum Destination {
        case homeViewController
        case sideMenuViewController
        case signInViewController
        case signUpViewController
        case forgetPasswordViewController
    }
    
    func navigate(To destination: Destination) {
        guard let vc = makeViewController(for: destination) else{return}
        navigationController.pushViewController(vc, animated: true)
    }
    
    func present(_ destination: Destination, completion: @escaping (() -> Void)) {
        guard let vc = makeViewController(for: destination) else{return}
        navigationController.present(vc, animated: true) {
            completion()
        }
    }
    
    func makeViewController(for destination: Destination)-> UIViewController? {
        switch destination {
        case .homeViewController:
//            let vc = HomeViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: HomeViewController())
//            return vc
            return BaseViewController()
        case .sideMenuViewController:
            let vc = MenuViewController.InstantiateFormStoryBoard(storyboards.main.instanse,
                                                                  vc: MenuViewController())
            return vc
        case .signInViewController:
            let vc = SignInViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse,
                                                                    vc: SignInViewController())
            return vc
        case .signUpViewController:
            let vc = SignUpViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse,
                                                                    vc: SignUpViewController())
            return vc
        case .forgetPasswordViewController:
            let vc = ForgetPasswordViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse,
                                                                            vc: ForgetPasswordViewController())
            return vc
        }
    }
    
}
