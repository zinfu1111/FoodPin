//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/8/24.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - WalkthroughPageViewControllerDelegate
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
        
    }

    @IBAction func nextButtonTapped(sender: UIButton) {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                createQuickActions()
                dismiss(animated: true, completion: nil)
                
            default:
                break
            }
        }
        
        
        updateUI()
    }
    
    func updateUI() {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
                
            default:
                break
            }
            
            
            pageControl.currentPage = index
        }
    }
    

    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        createQuickActions()
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
        
    }
    
    func createQuickActions() {
            //加入快速動作
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            
            let shortcutItem1 = UIApplicationShortcutItem(type:"\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "favorite"), userInfo: nil)
            
            let shortcutItem2 = UIApplicationShortcutItem(type:"\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "discover"), userInfo: nil)
            
            let shortcutItem3 = UIApplicationShortcutItem(type:"\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
            
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
            
        }
    }
}
