//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/8/2.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet var mapView: MKMapView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(locaiton: String) {
        
        let geoCoder = CLGeocoder()
        
        
        print(locaiton)
        geoCoder.geocodeAddressString(locaiton, completionHandler: { placemarks, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                
                //取得第一個地點標記
                let placemark = placemarks[0]
                
                //顯示標記
                let annotation = MKPointAnnotation()
                
                //設定縮放程度
                if let location = placemark.location {
                    
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    
                    self.mapView.setRegion(region, animated: true)
                    
                }
            }
            
        })
        
    }
}
