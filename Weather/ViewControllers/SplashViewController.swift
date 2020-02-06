//
//  SplashViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 04/10/19.
//  Copyright © 2019 Aguido. All rights reserved.
//
import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoApp: UIImageView!
    @IBOutlet weak var uiGradientView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingText: UILabel!
    @IBOutlet weak var imageLoading: UIImageView!
    var scoreResults: [ScoreResult]?
    var count: Int = 0
    
    override func viewDidLoad() {
        applyGradient()
        scoreResults = LegacyCalls().callMongo(label: loadingText, clazz: self)
        Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true, block: { timer in
            self.activityIndicator.stopAnimating()
            self.imageLoading.image = UIImage(named: LegacyCalls().images[self.count])
            self.count += 1
            if (self.count == LegacyCalls().images.count) {
                self.count = 0
            }
        })
    }
    
    func applyGradient(){
        self.activityIndicator.hidesWhenStopped = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = uiGradientView.bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.blue.cgColor
        ]
        uiGradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
