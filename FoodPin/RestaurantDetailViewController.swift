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
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var locationLabel:UILabel!
    @IBOutlet var typeLabel:UILabel!
    
    var restaurantImageName = ""
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.largeTitleDisplayMode = .never
        self.restaurantImageView.image = UIImage(named: restaurantImageName)
        self.nameLabel.text = restaurantName
        self.typeLabel.text = restaurantType
        self.locationLabel.text = restaurantLocation
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
