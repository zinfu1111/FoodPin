//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/7/12.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    
    
    var restaurantImageName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.largeTitleDisplayMode = .never
        self.restaurantImageView.image = UIImage(named: restaurantImageName)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
