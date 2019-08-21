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
    let presentNVC = UINavigationController()
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
                                         _ categoryId: Category?)
        case filterViewController(_ filterCallBack: (([String: Bool])->Void)?,
                                  _ category: Category?,
                                  _ filterDict: [String: Bool])
        case itemDetailsViewController(_ productId: Int)
        case auctionDetailsViewController(_ productId: Int)
        
        //My Account VC
        case myAccountViewController
        case myOrdersViewController
        case favoritesViewController
        case notificationViewController
        case addressesViewController
        case selectAddressViewController(_ address: String?)
        
        //Cart VC
        case cartViewController
        // child navigator in cart VC
        case cartPageViewController
        case cartAddressViewController(_ dataCallback: (([Address])->Void)?)
        case cartPaymentViewController(_ items: [CartProduct], _ addresses: [Address], dataCallback: ((PaymentMethod)->Void))
        case cartFinishedViewController
    }
    
    func navigate(To destination: Destination) {
        guard let vc = makeViewController(for: destination) else{return}
        currentVC = destination
        navigationController.pushViewController(vc, animated: true)
    }
    
    func present(_ destination: Destination, completion: (() -> Void)?) {
        guard let vc = makeViewController(for: destination) else{return}
        presentNVC.viewControllers.append(vc)
        //currentVC = destination
        navigationController.present(presentNVC, animated: true) {
            completion?()
        }
    }
    
    func presentNavigateTo(_ destination: Destination) {
        guard let vc = makeViewController(for: destination) else{return}
        currentVC = destination
        presentNVC.pushViewController(vc, animated: true)
    }
    
    func popViewController(to destination: Destination?){
        currentVC = destination
        navigationController.popViewController(animated: true)
    }
    
    func makeViewController(for destination: Destination)-> UIViewController? {
        switch destination {
        //MARK:- home and sideMenu
        case .homeViewController:
            let vc = HomeViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: HomeViewController())
            return vc
        case .sideMenuViewController:
            let vc = MenuViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: MenuViewController())
            return vc
        
        //MARK:- Signin
        case .signInViewController:
            let vc = SignInViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: SignInViewController())
            return vc
        case .signUpViewController:
            let vc = SignUpViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: SignUpViewController())
            return vc
        case .forgetPasswordViewController:
            let vc = ForgetPasswordViewController.InstantiateFormStoryBoard(storyboards.signIn.instanse, vc: ForgetPasswordViewController())
            return vc
            
        //MARK:- category items and filter
        case .categoryItemsViewController(let title, let products, let category):
            let vc = CategoryItemsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CategoryItemsViewController())
            vc?.title = title
            vc?.category = category
            guard let products = products else { return vc }
            vc?.viewModel.allProducts = products
            return vc
        case .filterViewController(let filterCallBack, let category, let filterDict):
            let vc = FilterViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: FilterViewController())
            vc?.category = category
            vc?.filterDict = filterDict
            vc?.filterCallback = filterCallBack
            return vc
        case .itemDetailsViewController(let productId):
            let vc = ItemDetailsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: ItemDetailsViewController())
            vc?.productId = productId
            return vc
        case .auctionDetailsViewController(let productId):
            let vc = AuctionDetailsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: AuctionDetailsViewController())
            vc?.productId = productId
            return vc
        
        //MARK:- myAccount
        case .myAccountViewController:
            let vc = MyAccountViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: MyAccountViewController())
            return vc
        case .myOrdersViewController:
            let vc = MyOrdersViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: MyOrdersViewController())
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
        case .selectAddressViewController(let address):
            let vc = SelectAddressViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: SelectAddressViewController())
            vc?.address = address
            return vc
            
        //MARK:- Cart
        case .cartViewController:
            let vc = CartViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartViewController())
            return vc
        case .cartPageViewController:
            let vc = CartPageViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartPageViewController())
            return vc
        case .cartAddressViewController(let dataCallback):
            let vc = CartAddressesViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartAddressesViewController())
            vc?.dataCallback = dataCallback
            return vc
        case .cartPaymentViewController(let items, let addresses, let dataCallback):
            let vc  = CartPaymentViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartPaymentViewController())
            
            return vc
        case .cartFinishedViewController:
            let vc  = CartFinishedViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: CartFinishedViewController())
            return vc
        }
    }
    
}
