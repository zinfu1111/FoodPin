//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/8/2.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

