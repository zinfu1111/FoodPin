//
//  SceneDelegate.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/7/4.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    enum QuickAction: String {
        case OpenFavorites = "OpenFavorites"
        case OpenDiscover = "OpenDiscover"
        case NewRestaurant = "NewRestaurant"
        
        init?(fullIdenitifier: String) {
            
            guard let shortcutIdenitifier = fullIdenitifier.components(separatedBy: ".").last else {
                return nil
            }
            
            self.init(rawValue: shortcutIdenitifier)
        }
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem: shortcutItem))
    }

    private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        let shortcutType = shortcutItem.type
        guard let shortcutIdentifier = QuickAction(fullIdenitifier: shortcutType) else { return false }
        guard let tabBarController  = window?.rootViewController as? UITabBarController else { return false }
        
        
        switch shortcutIdentifier {
        case .OpenFavorites:
            tabBarController.selectedIndex = 0
            print(0)
        case .OpenDiscover:
            tabBarController.selectedIndex = 1
            print(1)
        case .NewRestaurant:
            print(2)
            if let navController = tabBarController.viewControllers?[0] {
                let restaurantTableViewController = navController.children[0]
                restaurantTableViewController.performSegue(withIdentifier: "addRestaurant", sender: restaurantTableViewController)
                
            } else {
                return false
            }
            
        }
        
        return true
    }
}

