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

    @IBOutlet weak var myAccountBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        headerSetup()
        registerMenuCell()
        loadMenuTableView()
        viewModel.sendMenuItems()
        menuTableView.rx.itemSelected.subscribe {[unowned self] (event) in
            guard let indexPath = event.element else {return}
            self.menuTableViewDidSelectItem(in: indexPath)
        }.disposed(by: bag)
    }
    
    func headerSetup(){
        myAccountBtn.imageContentMode = .scaleAspectFit
        notificationBtn.imageContentMode = .scaleAspectFit
        favoritesBtn.imageContentMode = .scaleAspectFit
        cartBtn.imageContentMode = .scaleAspectFit
        
        if AppUtility.shared.currentLang == .ar{
            categoriesLbl.textAlignment = .right
        }else{
            categoriesLbl.textAlignment = .left
        }
    }
    
    func registerMenuCell(){
        let nib = UINib(nibName: "MenuCell", bundle: .main)
        menuTableView.register(nib, forCellReuseIdentifier: "MenuCell")
    }
    
    func loadMenuTableView(){
        menuTableView.delegate = nil
        menuTableView.dataSource = nil
        
        viewModel.menuElements
            .bind(to: menuTableView.rx.items){ tableView, row, element in
            let index = IndexPath(row: row, section: 0)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: index) as? MenuCell else {return MenuCell()}
            cell.bindOn(element)
            return cell
        }.disposed(by: bag)
    }
    
    func menuTableViewDidSelectItem(in indexPath: IndexPath){
        let element = MenuElements.element(row: indexPath.row)
        switch element{
            
        case .MOBILES_AND_TAPLETS,
             .CLOTHES_AND_SHOSES_AND_ACCESSORIES,
             .CUMPUTERS_AND_NETWORKS_AND_PROGRAMS,
             .ELECTRONICS,
             .FURNITURE_AND_HOUSE_DECORATION,
             .GARDEN_SUPPLIES,
             .HELTH_AND_SELF_CARE,
             .JEWELERY_AND_ACCESSORIES,
             .KITCHEN_AND_HOUSE_SUPPLIES,
             .OFFICE_EQUIPMENTS:
            
            NavigationCoordinator.shared.mainNavigator.navigate(To: .categoryItemsViewController(element.title))
            
        case .CHANGE_LANG:
            AppUtility.shared.changeLanguage()
        default:
            break
        }
        closeMenu()
    }
}
