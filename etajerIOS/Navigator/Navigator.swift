//
//  Navigator.swift
//  NavigatorDemo
//
//  Created by Mohamed Hussien on 17/04/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit


protocol Navigator {
    associatedtype Destination
    func navigate(To destination: Destination)
    func present(_ destination: Destination, completion: (()->Void)?)
}
