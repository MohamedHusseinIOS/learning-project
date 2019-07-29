//
//  CartPaymentViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/25/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class CartPaymentViewController: BaseViewController {

    @IBOutlet weak var paymentTableView: UITableView!
    
    let viewModel = CartPaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let items = [["": nil]]
        
        let sections = [SectionModel<String, [String: Any?]>(model: PAYMENT_METHOD.localized(), items: items),
                        SectionModel<String, [String: Any?]>(model: ORDER_SUMMERY.localized(), items: items),
                        SectionModel<String, [String: Any?]>(model: TRANSPORT_TO.localized(), items: items),
                        SectionModel<String, [String: Any?]>(model: YOUT_OREDER_ITEMS.localized(), items: items)]
        
        viewModel.input.data.onNext(sections)
    }
    
    override func configureUI() {
        super.configureUI()
        registerCells()
        configureTableView()
        
        viewModel.output.data.bind {[unowned self] (_) in
            self.paymentTableView.reloadData()
        }.disposed(by: bag)
    }
    
    func registerCells() {
        let sectionCellNib = UINib(nibName: "SectionCell", bundle: .main)
        paymentTableView.register(sectionCellNib, forCellReuseIdentifier: "SectionCell")
        
        let paymentMethodNib = UINib(nibName: "PaymentMethodCell", bundle: .main)
        paymentTableView.register(paymentMethodNib, forCellReuseIdentifier: "PaymentMethodCell")
        
        let addressNib = UINib(nibName: "CartAddressCell", bundle: .main)
        paymentTableView.register(addressNib, forCellReuseIdentifier: "CartAddressCell")
        
        let OrderSummeryNib = UINib(nibName: "OrderSummeryCell", bundle: .main)
        paymentTableView.register(OrderSummeryNib, forCellReuseIdentifier: "OrderSummeryCell")
        
        let yourOrderItemsNib = UINib(nibName: "YourOrderItemsCell", bundle: .main)
        paymentTableView.register(yourOrderItemsNib, forCellReuseIdentifier: "YourOrderItemsCell")
        
    }
    
    func configureTableView() {
        paymentTableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, [String: Any?]>>(configureCell:{[unowned self] dataSource, tableView, indexPath, item in
            switch indexPath.section{
            case 0:
               return self.makePaymentMethodCellForm(tableView: tableView, at: indexPath, with: item)
            case 1:
                return self.makeOrderSummeryCellForm(tableView: tableView, at: indexPath, with: item)
            case 2:
                return self.makeAddressCellForm(tableView: tableView, at: indexPath, with: item)
            case 3:
                return self.makeOrderItemsCellFrom(tableView: tableView, at: indexPath, with: item)
            default:
                return UITableViewCell()
            }
        })
        
        viewModel.output.data.bind(to: paymentTableView.rx.items(dataSource: dataSource)).disposed(by: bag)
    }
    
    func makePaymentMethodCellForm(tableView: UITableView,at index: IndexPath, with data: [String:Any?]) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: index) as? PaymentMethodCell else { return UITableViewCell() }
        cell.bindOnData()
        cell.selection = { selectedMethod in
            switch selectedMethod {
            case .creditCard:
                break
            case .cash:
                break
            }
        }
        return cell
    }
    
    func makeAddressCellForm(tableView: UITableView, at index: IndexPath, with data: [String:Any?]) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartAddressCell", for: index) as? CartAddressCell else { return UITableViewCell() }
        return cell
    }
    
    func makeOrderSummeryCellForm(tableView: UITableView, at index: IndexPath, with data: [String:Any?]) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderSummeryCell", for: index) as? OrderSummeryCell else { return UITableViewCell() }
        return cell
    }
    
    func makeOrderItemsCellFrom(tableView: UITableView, at index: IndexPath, with data: [String:Any?]) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YourOrderItemsCell", for: index) as? YourOrderItemsCell else { return UITableViewCell() }
        cell.bindOnData()
        return cell
    }
    
}

extension CartPaymentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as? SectionCell else { return SectionCell() }
        view.sectionTitle.text = viewModel.dataArray[section].model
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


