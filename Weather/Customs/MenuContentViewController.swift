//
//  MenuContentViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 09/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import UIKit
import SideMenu

class MenuContentViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var jiraUser: JiraUser?
    var menus: [String] = ["Sugestões", "Sair"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        nameLabel.text = jiraUser?.displayName
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
        //let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_trophy_background"))
        //imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //tableView.backgroundView = imageView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!

        // set the text from the data model
        cell.textLabel?.text = self.menus[indexPath.row]

        return cell
    }
}
