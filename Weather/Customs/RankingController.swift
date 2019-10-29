//
//  MenuRankingItem.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 14/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import UIKit

class RankingController: UITableViewController {
    
    var jiraUser: JiraUser?
    var allScores = [ScoreResult]()
    var scoresTemp = [ScoreResult]()
    var scores = [ScoreResult]()
    var history: ScoreHistory?
    let cellIdentifier = "cellItemIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresTemp = scores
        scores = LegacyCalls().getLastUpdatedSystems(scores: scores) // ultimos 18
        scores = LegacyCalls().oderListByScore(scoreResults: scores) // ultimos 18 ordenados por score
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RankingItem
        
        cell.sysName?.text = scores[indexPath.row].applicationName
        cell.sysImage?.image = UIImage(named: scores[indexPath.row].iconString!)
        cell.sysScore?.text = "Score: \(scores[indexPath.row].score)"
        cell.medalImage?.image = UIImage(named: scores[indexPath.row].medal ?? "ic_menu")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "SelectedSystemViewController") as! SelectedSystemViewController
        history = LegacyCalls().getSystemHistory(sysName: scores[indexPath.row].applicationName, scores: allScores)
        
        controller.allScores = allScores
        controller.system = scores[indexPath.row]
        controller.systems = scoresTemp
        controller.jiraUser = jiraUser
        controller.scoreHistory = history
        
        self.present(controller, animated: true, completion: nil)
    }
    
}
