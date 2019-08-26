//
//  MyAccountViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/17/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseViewController {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var membershipNumberLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var myAccountTableView: UITableView!
    
    let viewModel = MyAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.sendElemnts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserData()
    }
    
    override func configureUI() {
        super.configureUI()
        registerCell()
        
        if AppUtility.shared.currentLang == .ar {
            backImg.image = #imageLiteral(resourceName: "white-back-ar")
        } else {
            backImg.image = #imageLiteral(resourceName: "white-back-en")
        }
        
        backBtn.rx.tap.subscribe {[unowned self] _ in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
        configureTableView()
    }
    
    func registerCell(){
        let nib = UINib(nibName: "MyAccountCell", bundle: .main)
        myAccountTableView.register(nib, forCellReuseIdentifier: "MyAccountCell")
    }
    
    func configureTableView(){
        viewModel.output
            .myAccountElements
            .bind(to: myAccountTableView.rx.items){ tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyAccountCell", for: indexPath) as? MyAccountCell else { return MyAccountCell() }
                cell.bindOn(MyAccountElements.element(row: row))
                return cell
        }.disposed(by: bag)
        
        myAccountTableView.rx
            .itemSelected
            .subscribe {[unowned self] (event) in
                guard let indexPath = event.element else { return }
                self.selectCell(at: indexPath)
        }.disposed(by: bag)
    }
    
    func flashCellAt(indexPath: IndexPath){
        myAccountTableView.cellForRow(at: indexPath)?.backgroundColor = Colors.PrimaryColor.value
        DispatchQueue.main.asyncAfter(deadline: .now()) { [unowned self] in
            UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                self.myAccountTableView.cellForRow(at: indexPath)?.backgroundColor = .none
            })
        }
    }
    
    func selectCell(at indexPath: IndexPath){
        flashCellAt(indexPath: indexPath)
        let myAccountElemant = MyAccountElements.element(row: indexPath.row)
        switch myAccountElemant {
        case .MY_ORDERS:
            NavigationCoordinator.shared.mainNavigator.navigate(To: .myOrdersViewController)
        case .FAVORITES:
            NavigationCoordinator.shared.mainNavigator.navigate(To: .favoritesViewController)
        case .NOTIFICATION:
            NavigationCoordinator.shared.mainNavigator.navigate(To: .notificationViewController)
        case .ADDRESSES:
            NavigationCoordinator.shared.mainNavigator.navigate(To: .addressesViewController)
        default:
            break
        }
    }
    
    func setUserData(){
        let user = AppUtility.shared.getCurrentUser()
        userNameLbl.text = user?.name
        membershipNumberLbl.text = "\(user?.id ?? 0)"
    }
    
    
}
