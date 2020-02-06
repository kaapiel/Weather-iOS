//
//  RankingViewController.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 04/10/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit
import SideMenu

class RankingViewController: UIViewController {
    
    var scores = [ScoreResult]()
    var allScores = [ScoreResult]()
    var scoresTemp = [ScoreResult]()
    var jiraUser: JiraUser?
    private var embeddedViewController: RankingController!
    @IBOutlet weak var linesNumber: UILabel!
    @IBOutlet weak var issuesNumber: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBAction func onTouch(_ sender: Any) {
        let menu = (storyboard?.instantiateViewController(withIdentifier: "WeatherSideMenuController") as! WeatherSideMenuController)
        menu.settings = makeSettings()
        menu.jiraUser = jiraUser
        present(menu, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        applyGradientToHeader()
        updateData()
    }
    
    func updateData() {
        lastUpdated.text = "Atualizado por último em \(LegacyCalls().getLastUpdated(scores: scores))"
        linesNumber.text = LegacyCalls().getLinesSum(scores: scores)
        issuesNumber.text = LegacyCalls().getIssuesSum(scores: scores)
    }
    
    //método executado antes do viewDidLoad
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        allScores = scores
        scores = LegacyCalls().getLastUpdatedSystems(scores: scores) //pega os ultimos sistemas (18?)
        
        if let vc = segue.destination as? RankingController, segue.identifier == "tableViewSegue" {
            self.embeddedViewController = vc
            self.embeddedViewController.allScores = allScores
            self.embeddedViewController.scores = scores
            self.embeddedViewController.scoresTemp = scoresTemp
            self.embeddedViewController.jiraUser = jiraUser
        }
    }
    
    func applyGradientToHeader() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = mainView.bounds
        
        gradientLayer.colors = [
            UIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 1.0).cgColor,
            UIColor.white.cgColor
        ]
        
        gradientLayer.shouldRasterize = true
        mainView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension RankingViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
    private func makeSettings() -> SideMenuSettings {
        
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.menuStartAlpha = CGFloat(0.5)
        presentationStyle.menuScaleFactor = CGFloat(0.5)
        presentationStyle.onTopShadowOpacity = 0.8
        presentationStyle.presentingEndAlpha = CGFloat(0.5)
        presentationStyle.presentingScaleFactor = CGFloat(0.8)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * 0.75
        settings.blurEffectStyle = .none
        settings.presentationStyle.presentingEndAlpha = 0.5
        
        return settings
        
    }
}
