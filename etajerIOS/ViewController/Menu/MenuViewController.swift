//
//  MenuViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/7/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MenuViewController: BaseViewController {

    @IBOutlet weak var notSigninHeader: UIView!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var userDataHeader: UIView!
    @IBOutlet weak var userActionsStackViewHeader: UIStackView!
    @IBOutlet weak var sellingHeader: UIView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var membershipNumberLbl: UILabel!
    @IBOutlet weak var myAccountBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var sellLbl: UILabel!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if AppUtility.shared.currentAccessToken != nil {
            notSignin(false)
        } else {
            notSignin(true)
        }
        
        setUserData()
    }
    
    override func configureUI() {
        super.configureUI()
        
        headerSetup()
        registerMenuCell()
        loadMenuTableView()
        
        menuTableView.rx.itemSelected.subscribe {[unowned self] (event) in
            guard let indexPath = event.element else {return}
            self.menuTableViewDidSelectItem(in: indexPath)
        }.disposed(by: bag)
        
        signinBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.present(.signInViewController, completion: nil)
        }.disposed(by: bag)
    }
    
    override func configureData() {
        super.configureData()
        
        viewModel.output
            .faliure
            .bind {[unowned self] (errors) in
                guard let errorMsg = errors.first?.message else { return }
                self.alert(title: "", message: errorMsg, completion: nil)
        }.disposed(by: bag)
    }
    
    func notSignin(_ bool: Bool){
        notSigninHeader.isHidden = !bool
        userDataHeader.isHidden = bool
        userActionsStackViewHeader.isHidden = bool
        sellingHeader.isHidden = bool
    }
    
    func setUserData(){
        guard let user = AppUtility.shared.getCurrentUser() else { return }
        userNameLbl.text = user.name
        membershipNumberLbl.text = "\(user.id ?? 0)"
    }
    
    func headerSetup(){
        setUserData()
        myAccountBtn.imageContentMode = .scaleAspectFit
        notificationBtn.imageContentMode = .scaleAspectFit
        favoritesBtn.imageContentMode = .scaleAspectFit
        cartBtn.imageContentMode = .scaleAspectFit
        
        if AppUtility.shared.currentLang == .ar{
            sellLbl.textAlignment = .right
            categoriesLbl.textAlignment = .right
        }else{
            sellLbl.textAlignment = .left
            categoriesLbl.textAlignment = .left
        }
        
        myAccountBtn.rx
            .tap
            .subscribe {[unowned self] (_) in
                if AppUtility.shared.currentAccessToken != nil {
                    NavigationCoordinator.shared.mainNavigator.navigate(To: .myAccountViewController)
                } else {
                NavigationCoordinator.shared.mainNavigator.present(.signInViewController, completion: nil)
                }
                
                self.closeMenu()
        }.disposed(by: bag)
        
        notificationBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.navigate(To: .notificationViewController)
        }.disposed(by: bag)
        
        favoritesBtn.rx
            .tap
            .subscribe {[unowned self] _ in
                NavigationCoordinator.shared.mainNavigator.navigate(To: .favoritesViewController)
                self.closeMenu()
        }.disposed(by: bag)
    
        cartBtn.rx.tap.bind { (_) in
            NavigationCoordinator.shared.mainNavigator.navigate(To: .cartViewController)
        }.disposed(by: bag)
        
    }
    
    func registerMenuCell(){
        let nib = UINib(nibName: "MenuCell", bundle: .main)
        menuTableView.register(nib, forCellReuseIdentifier: "MenuCell")
    }
    
    func loadMenuTableView(){
        menuTableView.delegate = nil
        menuTableView.dataSource = nil
        
        viewModel.output
            .menuElements
            .bind(to: menuTableView.rx.items){ tableView, row, element in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: index) as? MenuCell else {return MenuCell()}
                cell.bindOn(element)
                return cell
        }.disposed(by: bag)
        
    }
    
    func menuTableViewDidSelectItem(in indexPath: IndexPath){
        let category = viewModel.categories[indexPath.row]
        if indexPath.row == viewModel.categories.count - 1 {
            AppUtility.shared.changeLanguage()
        } else {
            guard let title = category.name, let id = category.id else { return }
            NavigationCoordinator.shared.mainNavigator.navigate(To: .categoryItemsViewController(title, nil, category))
        }
        flashCellAt(indexPath: indexPath)
        closeMenu()
    }
    
    func flashCellAt(indexPath: IndexPath){
        menuTableView.cellForRow(at: indexPath)?.backgroundColor = Colors.PrimaryColor.value
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let self = self else { return }
                self.menuTableView.cellForRow(at: indexPath)?.backgroundColor = .none
            })
        }
    }
}
