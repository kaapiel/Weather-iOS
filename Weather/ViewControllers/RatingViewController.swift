//
//  RatingViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewControler: UIViewController {
    
    @IBOutlet weak var rating: CosmosView?
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        rating?.isUserInteractionEnabled = true
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 1.0).cgColor,
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        ]
        
        gradientLayer.shouldRasterize = true
        backgroundGradientView.layer.addSublayer(gradientLayer)
        
    }
    @available(iOS 13.0, *)
    @IBAction func onTouch(_ sender: Any) {
        
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "ThanksViewController")
        
        let viewController = controller as! ThanksViewController
        
        if let controller = topMostViewController() {
            controller.present(viewController, animated: true)
        }
        
    }
    
    @available(iOS 13.0, *)
    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    
    @available(iOS 13.0, *)
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
    }
    
    private func topMostViewController(for controller: UIViewController) -> UIViewController? {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
    
}
