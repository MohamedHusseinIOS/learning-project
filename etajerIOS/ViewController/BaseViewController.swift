//
//  ViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import UIKit
import RxSwift

protocol configrationContract {
    func configureUI()
}

class BaseViewController: UIViewController, configrationContract, Instantiator {
    
    let tap = UITapGestureRecognizer()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureData()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    /// called in super viewDidLoad of (BaseViewController)
    func configureUI() {
        tap.addTarget(self, action: #selector(endEditing(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2761612535, green: 0.1481507123, blue: 0.3897372484, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
    }
    
    func configureData(){
        
    }

    func openMenu(){
        switch AppUtility.shared.currentLang{
        case .en:
            openLeft()
        case .ar:
            openRight()
        }
    }
    
    func closeMenu(){
        switch AppUtility.shared.currentLang{
        case .en:
            closeLeft()
        case .ar:
            closeRight()
        }
    }
    
    @objc func endEditing(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func backBtnTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}

