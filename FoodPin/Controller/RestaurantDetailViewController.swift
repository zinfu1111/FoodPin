//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/7/12.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
        
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
