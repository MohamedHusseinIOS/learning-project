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
    var currentVC: Destination?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension MainNavigator: Navigator{
    //MARK:- Destination
    enum Destination {
        
        //SignIn Stroyboard
        case signInViewController
        case signUpViewController
        case forgetPasswordViewController
        
        //Main Storyboard
        case homeViewController
        case sideMenuViewController
        //Categories
        case categoryItemsViewController(_ categoryName: String,
                                         _ products: [Product]?,
                                         _ categoryId: Int?)
        case itemDetailsViewController(_ productId: Int)
        case auctionDetailsViewController(_ productId: Int)
        
        //My Account VC
        case myAccountViewController
        case favoritesViewController
        case notificationViewController
        case addressesViewController
        
        //Cart VC
        case cartViewController
        // child navigator in cart VC
        case cartPageViewController
        case cartAddressViewController
        case cartPaymentViewController
        case cartFinishedViewController
    }
    
    func navigate(To destination: Destination) {
        guard let vc = makeViewController(for: destination) else{return}
        currentVC = destination
        navigationController.pushViewController(vc, animated: true)
    }
    
    func present(_ destination: Destination, completion: @escaping (() -> Void)) {
        guard let vc = makeViewController(for: destination) else{return}
        currentVC = destination
        navigationController.present(vc, animated: true) {
            completion()
        }
    }
    
    func popViewController(to destination: Destination?){
        currentVC = destination
        navigationController.popViewController(animated: true)
    }
    
    func makeViewController(for destination: Destination)-> UIViewController? {
        switch destination {
        case .homeViewController:
            let vc = HomeViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: HomeViewController())
            return vc
        case .sideMenuViewController:
            let vc = MenuViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: MenuViewController())
            return vc
        case .signInViewController:
            let vc = SignInViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: SignInViewController())
            return vc
        case .signUpViewController:
            let vc = SignUpViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: SignUpViewController())
            return vc
        case .forgetPasswordViewController:
            let vc = ForgetPasswordViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: ForgetPasswordViewController())
            return vc
        case .categoryItemsViewController(let title, let products, let categoryId):
            let vc = CategoryItemsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CategoryItemsViewController())
            vc?.title = title
            vc?.categoryId = categoryId
            guard let products = products else { return vc }
            vc?.configureItemsCollection()
            vc?.viewModel.input.products.onNext(products)
            return vc
            
            
        case .itemDetailsViewController(let productId):
            let vc = ItemDetailsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: ItemDetailsViewController())
            vc?.productId = productId
            return vc
        case .auctionDetailsViewController(let productId):
            let vc = AuctionDetailsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: AuctionDetailsViewController())
            vc?.productId = productId
            return vc
            

        case .myAccountViewController:
            let vc = MyAccountViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: MyAccountViewController())
            return vc
        case .favoritesViewController:
            let vc  = FavoritesViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: FavoritesViewController())
            return vc
        case .notificationViewController:
            let vc = NotificationsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: NotificationsViewController())
            return vc
        case .addressesViewController:
            let vc = AddressesViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: AddressesViewController())
            return vc
        case .cartViewController:
            let vc = CartViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartViewController())
            return vc
        case .cartPageViewController:
            let vc = CartPageViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartPageViewController())
            return vc
        case .cartAddressViewController:
            let vc = CartAddressesViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartAddressesViewController())
            return vc
        case .cartPaymentViewController:
            let vc  = CartPaymentViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartPaymentViewController())
            return vc
        case .cartFinishedViewController:
            let vc  = CartFinishedViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartFinishedViewController())
            return vc
        }
    }
    
}
