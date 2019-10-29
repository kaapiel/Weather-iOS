//
//  LoginViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 04/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBox: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    var jiraUser: JiraUser?
    var scores = [ScoreResult]()
    
    override func viewDidLoad() {
        applyGradientToLoginBox()
        activityIndicator.hidesWhenStopped = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    func applyGradientToLoginBox(){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = loginBox.bounds
        
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.blue.cgColor
        ]
        
        gradientLayer.shouldRasterize = true
        loginBox.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        loginButton.setTitle("", for: .normal)
        loginButton.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        jiraUser = LegacyCalls().getJiraUser(email: emailField.text!, clazz: self, scores: scores)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}
