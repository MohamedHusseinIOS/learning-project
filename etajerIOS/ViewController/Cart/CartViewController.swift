//
//  CartViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/22/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: BaseViewController {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var headerView: CartHeaderView!
    @IBOutlet weak var childNavigationView: UIView!
    
    @IBOutlet weak var continueView: UIView!
    @IBOutlet weak var dayDateLbl: UILabel!
    @IBOutlet weak var continueLbl: UILabel!
    @IBOutlet weak var buyLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    let viewModel = CartViewModel()
    
    var addresses = [Address]()
    var items = [CartProduct]()
    var paymentMethod: PaymentMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.checkPage(.cart)
        continueBtn.isHidden = false
    }
    
    override func configureUI() {
        super.configureUI()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        backBtn.rx.tap.bind { [unowned self](_) in
            self.backTapped()
        }.disposed(by: bag)
        
        navigateToFirstPage()
        continueLbl.isHidden = true
        
        continueBtn.rx
            .tap
            .bind {[unowned self] (_) in
                self.continueTapped()
        }.disposed(by: bag)
    }
    
    func navigateToFirstPage(){
        guard let childRootVC = NavigationCoordinator.shared.mainNavigator?.makeViewController(for: .cartPageViewController) else { return }
        (childRootVC as? CartPageViewController)?.dataCallback = {[unowned self] data in
            self.items = data
        }
        let childNVC = UINavigationController(rootViewController: childRootVC)
        addChildNavigationController(navigation: childNVC, to: childNavigationView, in: self)
        NavigationCoordinator.shared.addChildNVC(childNVC, parentViewController: self)
        //this used just once here (any push after that Auto pass currentVC)
        NavigationCoordinator.shared.childNavigator?.currentVC = .cartPageViewController
    }
    
    func addChildNavigationController(navigation: UINavigationController, to containerView: UIView, in ViewController: UIViewController){
        navigation.setNavigationBarHidden(true, animated: false)
        navigation.willMove(toParent: ViewController)
        navigation.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: containerView.frame.size)
        containerView.addSubview(navigation.view)
        addChild(navigation)
        navigation.didMove(toParent: ViewController)
    }
    
    func backTapped(){
        switch NavigationCoordinator.shared.childNavigator?.currentVC {
        case .some(.cartPageViewController):
            navigationController?.popViewController(animated: true)
        case .some(.cartAddressViewController):
            NavigationCoordinator.shared.childNavigator?.popViewController(to: .cartPageViewController)
            headerView.checkPage(.cart)
            continueLbl.isHidden = true
            buyLbl.isHidden = false
            dayDateLbl.isHidden = false
        case .some(.cartPaymentViewController):
            NavigationCoordinator.shared.childNavigator?.popViewController(to: .cartAddressViewController(nil))
            headerView.checkPage(.address)
        case .some(.cartFinishedViewController):
            NavigationCoordinator.shared.mainNavigator.popViewController(to: .homeViewController)
        default:
            break
        }
    }
    
    func continueTapped(){
        switch NavigationCoordinator.shared.childNavigator?.currentVC {
        case .some(.cartPageViewController):
            let callback = {[unowned self] (data:[Address]) in
                self.addresses = data
            }
            NavigationCoordinator.shared.childNavigator?.navigate(To: .cartAddressViewController(callback))
            headerView.checkPage(.address)
            continueLbl.text = CONTENUE.localized()
            continueLbl.isHidden = false
            buyLbl.isHidden = true
            dayDateLbl.isHidden = true
        case .some(.cartAddressViewController):
            let callback = {[unowned self] (data: PaymentMethod) in
                self.paymentMethod = data
            }
            NavigationCoordinator.shared.childNavigator?.navigate(To: .cartPaymentViewController(items, addresses, dataCallback: callback))
            headerView.checkPage(.payment)
            continueLbl.text = CONFIRM_THE_OREDER.localized()
        case .some(.cartPaymentViewController):
            NavigationCoordinator.shared.childNavigator?.navigate(To: .cartFinishedViewController)
            headerView.checkPage(.done)
            continueView.isHidden = true
        
        default:
            break
        }
    }

}
