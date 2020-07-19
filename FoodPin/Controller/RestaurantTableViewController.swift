//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/7/4.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen", isVisited: false)
    ]
    
    // MARK: - 視圖控制器生命週期
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        Thread.sleep(forTimeInterval: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cellId = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.heartImageView.isHidden = !self.restaurants[indexPath.row].isVisited
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let optionMenu = UIAlertController(title: nil, message: "123", preferredStyle: .actionSheet)
//
//        if let popoverController = optionMenu.popoverPresentationController{
//            if let cell = tableView.cellForRow(at: indexPath){
//                popoverController.sourceView = cell
//                popoverController.sourceRect = cell.bounds
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//
//
//        let callActionHandler = {(action:UIAlertAction) -> Void in
//
//            let alertMessage = UIAlertController(title: "no", message: "no call", preferredStyle: .alert)
//
//            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//            self.present(alertMessage, animated: true, completion: nil)
//        }
//
//        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//
//        let alertTitle = self.restaurantIsVisited[indexPath.row] ? "Uncheck in" : "Check in"
//
//        let checkInAction = UIAlertAction(title: alertTitle, style: .default, handler: {
//            (action:UIAlertAction!) -> Void in
//
//            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
//
////            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .none : .checkmark
//
//            cell?.heartImageView.isHidden = self.restaurantIsVisited[indexPath.row]
//
//            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
//
//        })
//        optionMenu.addAction(checkInAction)
//
//        present(optionMenu,animated: true,completion: nil)
//
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action, sourceView, completionHandler) in
            
            // 從資料列刪除
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(systemName: "trash")
        
        
        let shareAction = UIContextualAction(style: .normal, title: "Share"){
            (action, sourceView, completionHandler) in
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
//            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image){
                
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                
            }else{
                
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                
            }
            
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkAction = UIContextualAction(style: .normal, title: "Check"){
            (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            
            cell?.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited
            self.restaurants[indexPath.row].isVisited = self.restaurants[indexPath.row].isVisited ? false : true
            
            completionHandler(true)
        }
        
        checkAction.backgroundColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        checkAction.image = self.restaurants[indexPath.row].isVisited ? UIImage(systemName: "arrow.uturn.left") : UIImage(systemName: "checkmark")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        
        return swipeConfiguration
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            restaurantNames.remove(at: indexPath.row)
            restaurantLocations.remove(at: indexPath.row)
            restaurantTypes.remove(at: indexPath.row)
            restaurantIsVisited.remove(at: indexPath.row)
            restaurantImages.remove(at: indexPath.row)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
//        tableView.reloadData()
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
        
    }
    

}
