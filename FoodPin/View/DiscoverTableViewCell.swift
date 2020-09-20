//
//  DiscoverTableViewCell.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/9/20.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var typeLabel: UILabel! 
    @IBOutlet var locationLabel: UILabel! {
        didSet {
            locationLabel.numberOfLines = 0
        }
    }
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    @IBOutlet var restaurantImageView: UIImageView! {
        didSet {
            restaurantImageView.contentMode = .scaleAspectFill
            restaurantImageView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
