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
        configureUI()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    func configureUI() {
        tap.addTarget(self, action: #selector(endEditing(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2745098039, green: 0.1490196078, blue: 0.3882352941, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc func endEditing(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}

