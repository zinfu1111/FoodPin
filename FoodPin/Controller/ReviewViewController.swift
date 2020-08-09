//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by 連振甫 on 2020/8/9.
//  Copyright © 2020 連振甫. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        //模糊效果
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //將按鈕移到外面
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        //隱藏按鈕
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        let moveTopTransform = CGAffineTransform.init(translationX: 0, y: -600)
        closeButton.transform = moveTopTransform
        closeButton.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //1.全部動畫淡出
//        UIView.animate(withDuration: 2.0, animations: {
//            for rateButton in self.rateButtons {
//                rateButton.alpha = 1.0
//            }
//        })
        
        //2.個別動畫
        
        //2-1彈簧動畫示範
//        UIView.animate(withDuration: 3, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.7, options: [], animations: {
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[0].transform = .identity
//        }, completion: nil)
        
        //2-2滑入動畫示範
        for i in 0...4 {
            UIView.animate(withDuration: 0.4, delay: 0.1+(Double(i)*0.05), options: [], animations: {
                self.rateButtons[i].alpha = 1.0
                self.rateButtons[i].transform = .identity
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.closeButton.alpha = 1.0
            self.closeButton.transform = .identity
        }, completion: nil)
        
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
