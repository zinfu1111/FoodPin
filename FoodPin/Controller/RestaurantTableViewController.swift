//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/7/4.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    @IBOutlet var emptyRstaurantView: UIView!
    
    var restaurants: [RestaurantMO] = []
    var searchResults: [RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var searchController: UISearchController!
    
    
    // MARK: - 視圖控制器生命週期
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),NSAttributedString.Key.font: customFont]
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
        tableView.tableHeaderView = searchController.searchBar
//        self.navigationItem.searchController = searchController
        
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        Thread.sleep(forTimeInterval: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.backgroundView = emptyRstaurantView
        tableView.backgroundView?.isHidden = true
        
        
        //從資料儲存區讀取資料
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        prepareNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "PaulFoodPin"
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "walkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
        
    }
    
    func prepareNotification() {
        //確認餐廳陣列
        if restaurants.count <= 0 {
            return
        }
        
        //隨機選擇一間餐廳
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]
        
        //建立使用者通知
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "check out\(suggestedRestaurant.name ?? "") At \(suggestedRestaurant.location ?? "")"
        content.sound = .default
        
        //設定圖片
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")
        
        if let image = UIImage(data: suggestedRestaurant.image! as Data) {
            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
                content.attachments = [restaurantImage]
            }
        }
        
        //設定Actions
        let categoryID = "foodpin.restaurantaction"
        let makeReservationAction = UNNotificationAction(identifier: "foodpin.makeReservation", title: "Reserve a table", options: [.foreground])
        
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryID, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryID
        content.userInfo = ["phone": suggestedRestaurant.phone ?? ""]
        
        
        
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
        
    }
    
    //MARK: - SearchController
    
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name,let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        }else{
            return restaurants.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cellId = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RestaurantTableViewCell
        
        //判斷要用搜尋結果還是原本的餐廳列表
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        
        //設定cell
        cell.nameLabel.text = restaurant.name
        if let restaurantImage = restaurant.image {
            cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        
        
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        cell.heartImageView.isHidden = !restaurant.isVisited
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        }else{
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action, sourceView, completionHandler) in
            
            //從資料儲存區刪除一列
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(systemName: "trash")
        
        
        let shareAction = UIContextualAction(style: .normal, title: "Share"){
            (action, sourceView, completionHandler) in
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
//            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            
            let activityController: UIActivityViewController
            
            if let restaurantImage = self.restaurants[indexPath.row].image, let imageToShare = UIImage(data: restaurantImage as Data){
                
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
        
        shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
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
        
        checkAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
        checkAction.image = self.restaurants[indexPath.row].isVisited ? UIImage(systemName: "arrow.uturn.left") : UIImage(systemName: "checkmark")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let configuration = UIContextMenuConfiguration(identifier: indexPath.row as NSCopying, previewProvider: {
            
            guard let restaurantDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return nil }
            
            let selectedRestaurant = self.restaurants[indexPath.row]
            restaurantDetailViewController.restaurant = selectedRestaurant
            
            return restaurantDetailViewController
            
        }){ actions in
            
            let checkInAction = UIAction(title: "Check-in", image: UIImage(systemName: "checkmark")){
                action in
                
                let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
                
                cell?.heartImageView.isHidden = self.restaurants[indexPath.row].isVisited
                self.restaurants[indexPath.row].isVisited = self.restaurants[indexPath.row].isVisited ? false : true
                
            }
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arror.up")){
                action in
                
                let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
    //            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                
                let activityController: UIActivityViewController
                
                if let restaurantImage = self.restaurants[indexPath.row].image,
                   let imageToShare = UIImage(data: restaurantImage as Data){
                    
                    activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                    
                }else{
                    
                    activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                    
                }
                
                self.present(activityController, animated: true, completion: nil)
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash")){
                action in
                
                //從資料儲存區刪除一列
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let context = appDelegate.persistentContainer.viewContext
                    let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                    context.delete(restaurantToDelete)
                    
                    appDelegate.saveContext()
                }
                
            }
            
            // Create and return a UIMenu with the share action
            return UIMenu(title: "", children: [checkInAction, shareAction, deleteAction])
            
        }
        
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
        guard let selectedRow = configuration.identifier as? Int else {
            print("Failed to retrieve the row number")
            return
            
        }
        
        guard let restaurantDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        
        let selectedRestaurant = self.restaurants[selectedRow]
        restaurantDetailViewController.restaurant = selectedRestaurant
        
        animator.preferredCommitStyle = .pop
        animator.addCompletion {
            self.show(restaurantDetailViewController, sender: self)
        }
        
        
    }
    
    // MARK: - Button Action
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
        
    }


}
