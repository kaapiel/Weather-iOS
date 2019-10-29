//
//  WeatherSideMenu.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 10/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import UIKit
import SideMenu

class WeatherSideMenuController: SideMenuNavigationController {
    
    var jiraUser: JiraUser?
    
    override func viewDidLoad() {
        let vc = viewControllers[0] as? MenuContentViewController
        vc?.jiraUser = jiraUser
    }
}
