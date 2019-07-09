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
    @IBOutlet weak var menuTableView: UITableView!
    
    
    
    let viewModel = MenuViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        super.configureUI()
        makeButtonsImagesFit()
        registerMenuCell()
        loadMenuTableView()
        viewModel.sendMenuItems()
        menuTableView.rx.itemSelected.subscribe {[unowned self] (event) in
            guard let indexPath = event.element else {return}
            self.menuTableViewDidSelectItem(in: indexPath)
        }.disposed(by: bag)
    }
    
    func makeButtonsImagesFit(){
        myAccountBtn.imageContentMode = .scaleAspectFit
        notificationBtn.imageContentMode = .scaleAspectFit
        favoritesBtn.imageContentMode = .scaleAspectFit
        cartBtn.imageContentMode = .scaleAspectFit
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
            
        case .MOBILES_AND_TAPLETS: break
            
        case .CLOTHES_AND_SHOSES_AND_ACCESSORIES: break
            
        case .HELTH_AND_SELF_CARE: break
            
        case .CUMPUTERS_AND_NETWORKS_AND_PROGRAMS: break
            
        case .GARDEN_SUPPLIES: break
            
        case .ELECTRONICS: break
            
        case .FURNITURE_AND_HOUSE_DECORATION: break
            
        case .KITCHEN_AND_HOUSE_SUPPLIES: break
            
        case .JEWELERY_AND_ACCESSORIES: break
            
        case .OFFICE_EQUIPMENTS: break
            
        }
        closeMenu()
    }
}
