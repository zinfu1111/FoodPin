//
//  UIColor+Ext.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/8/2.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        let redValue = CGFloat(red)/255.0
        let greenValue = CGFloat(green)/255.0
        let blueValue = CGFloat(blue)/255.0
        
        self.init(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}
