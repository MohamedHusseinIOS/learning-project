//
//  ViewController.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import UIKit

protocol configrationContract {
    func configureUI()
}

class BaseViewController: UIViewController, configrationContract, Instantiator {
    
    let tap = UITapGestureRecognizer()
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc func endEditing(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}

