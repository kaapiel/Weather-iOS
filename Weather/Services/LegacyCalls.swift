//
//  MongoCall.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 07/10/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import MongoKitten
import Combine

class LegacyCalls {
    
    var scoreResults: Array<ScoreResult> = Array()
    var actualSysName: String = "Carregando"
    var history: ScoreHistory?
    var qttSystems = 18
    var historySearch = 10
    var load = false
    var jiraUser: JiraUser?
    var finished: Bool = false
    
    let mongoIp = "10.82.252.152"
    let mongoPort = "27017"
    let mongoUser = "developer"
    let mongoPass = "C!elo_dev"
    let mongoConnectionPrefix = "mongodb://"
    let mongoDB = "dev-test"
    let mongoScoreCollection = "score"
    
    var images: [String] = ["ic_heart", "ic_3g", "ic_12x", "ic_48x", "ic_bulb", "ic_calendar", "ic_card", "ic_cards", "ic_cash", "ic_check", "ic_cloud_extract", "ic_delivery", "ic_ecommerce", "ic_facebook", "ic_flag", "ic_geo", "ic_gift", "ic_handshake", "ic_happy", "ic_infinity", "ic_law", "ic_lighthouse", "ic_lio", "ic_lock", "ic_monitor", "ic_no_cash", "ic_percent", "ic_plane", "ic_play", "ic_pos", "ic_push", "ic_quotes", "ic_receive_cash", "ic_return", "ic_right", "ic_search", "ic_smartmachine", "ic_store", "ic_talk", "ic_telephone", "ic_user", "ic_warn", "ic_wifi", "icon_lio_v2"]
    
    func callMongo(label: UILabel, clazz: Any) -> [ScoreResult] {
        
        DispatchQueue.main.async {
            
            do {
                
                let db = try MongoKitten.Database.synchronousConnect("\(self.mongoConnectionPrefix)\(self.mongoUser):\(self.mongoPass)@\(self.mongoIp):\(self.mongoPort)/\(self.mongoDB)")
                
                let scores = db["\(self.mongoScoreCollection)"]
                
                let sort: Sort = [
                    "_id": .ascending
                ]
                
                var totalDocs = 0;
                
                scores.find().forEach {_ in
                    totalDocs += 1
                }
                sleep(2)
                
                scores.find().sort(sort).forEach { (doc: Document) in
                    
                    var scoreResult: ScoreResult
                    
                    do {
                        
                        let json = try JSONEncoder().encode(doc)
                        scoreResult = try JSONDecoder().decode(ScoreResult.self, from: json)
                        scoreResult = self.setImageassetName(scoreResult: scoreResult)
                        
                        DispatchQueue.main.async {
                            self.scoreResults.append(scoreResult)
                            self.actualSysName = self.scoreResults[self.scoreResults.count-1].applicationName
                            label.text = self.actualSysName
                            print("\(scoreResult.applicationName) \(self.scoreResults.count)")
                            
                            if(self.scoreResults.count == 1527){
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Weather", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                newViewController.scores = self.scoreResults
                                (clazz as! SplashViewController).present(newViewController, animated: true, completion: nil)
                            }
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            } catch {
                print(error)
                self.actualSysName = "Aconteceu um erro 😫. Vamos fechar o aplicativo e voce tenta de novo, ok?"
            }
        }
        
        return scoreResults
    }
    
    func getLastUpdatedSystems(scores: [ScoreResult]) -> Array<ScoreResult> {
        return Array(scores.suffix(qttSystems))
    }
    
    func getIssuesSum(scores: [ScoreResult]) -> String {
        var issues: Int = 0
        
        for sr in scores {
            issues += sr.totalIssues
        }
        return issues.roundedWithAbbreviations
        
    }
    
    func getLinesSum(scores: [ScoreResult]) -> String {
        var lines: Int = 0
        
        for sr in scores {
            lines += sr.ncloc
        }
        return lines.roundedWithAbbreviations
    }
    
    func getLastUpdated(scores: [ScoreResult]) -> String {
        return scores[0].id.getDateStringFromUTC()
    }
    
    func getRandomImage() -> String {
        return images[Int.random(in: 0..<images.count)]
    }
    
    func getOverallObject() -> ScoreResult? {
        
        if let url = Bundle.main.url(forResource: "Assets/Overall", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ScoreResult.self, from: data)
                return jsonData
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func getSystemHistory(sysName: String, scores: [ScoreResult]) -> ScoreHistory {
        
        var scoreHistoryUnit: [ScoreHistoryUnit] = []
        var scoreHistory = ScoreHistory(sysName: "SysName", scoreHistoryUnit: scoreHistoryUnit)
        
        for sr in scores {
            if sr.applicationName == sysName {
                
                var scoreHistoryUnitSr = ScoreHistoryUnit(date: 0, score: 0)
                scoreHistoryUnitSr.date = sr.id
                scoreHistoryUnitSr.score = sr.score
                
                scoreHistoryUnit.append(scoreHistoryUnitSr)
            }
        }
        
        scoreHistory.scoreHistoryUnit = scoreHistoryUnit.suffix(10)
        scoreHistory.sysName = sysName
        return scoreHistory
    }
    
    func oderListByScore(scoreResults: [ScoreResult]) -> [ScoreResult] {
        
        let unorderedList = scoreResults
        var orderedList = unorderedList.sorted(by: { $0.score > $1.score })
        
        orderedList[0].medal = "ic_goldmedal"
        orderedList[1].medal = "ic_silvermedal"
        orderedList[2].medal = "ic_bronzemedal"
        
        return orderedList
    }
    
    func getJiraUser(email: String, clazz: Any, scores: [ScoreResult]) -> JiraUser? {
        
        if email == "" {
            print("e-mail inválido")
            (clazz as! LoginViewController).activityIndicator.stopAnimating()
            (clazz as! LoginViewController).loginButton.setTitle("ENTRAR", for: .normal)
            (clazz as! LoginViewController).loginButton.isUserInteractionEnabled = true
            return nil
        }
        
        guard let url = URL(string: "https://jiracielo.atlassian.net/rest/api/latest/user?username=\(email.split(separator: "@")[0])") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic dDIxMDZyc25AcHJlc3RhZG9yY2JtcC5jb20uYnI6R3FGMzZrNVI4ZDJWUzVna1VjSVpCMjE3", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                self.jiraUser = try JSONDecoder().decode(JiraUser.self, from: data)
                
                DispatchQueue.main.async {
                    print("Bem-vindo \(self.jiraUser?.displayName ?? "Mock da Silva")")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Weather", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "RankingViewController") as! RankingViewController
                    newViewController.jiraUser = self.jiraUser
                    newViewController.scores = scores
                    newViewController.scoresTemp = scores
                    (clazz as! LoginViewController).present(newViewController, animated: true, completion: nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    print("e-mail inválido")
                    (clazz as! LoginViewController).activityIndicator.stopAnimating()
                    (clazz as! LoginViewController).loginButton.setTitle("ENTRAR", for: .normal)
                    (clazz as! LoginViewController).loginButton.isUserInteractionEnabled = true
                }
            }
            
        }.resume()
        
        return self.jiraUser
    }
    
    func downloadImage() -> Data?{
        
        var imageData: Data?
        
        getData(from: URL(string: jiraUser!.avatarUrls.the48X48!)!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageData = data;
            }
        }
        return imageData
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func setImageassetName(scoreResult: ScoreResult) -> ScoreResult {
        
        var sr = scoreResult
        
        switch scoreResult.applicationName {
        case Constants().APP:
            sr.iconString = "ic_lio" as String
            return sr
        case Constants().CANCELAMENTO:
            sr.iconString = "ic_no_cash" as String
            return sr
        case Constants().CENTRALIZADOR:
            sr.iconString = "ic_handshake" as String
            return sr
        case Constants().CIELOPAY:
            sr.iconString = "ic_user" as String
            return sr
        case Constants().CREDENCIAMENTO:
            sr.iconString = "ic_receive_cash" as String
            return sr
        case Constants().MONETIZACAO:
            sr.iconString = "ic_cash" as String
            return sr
        case Constants().NGC:
            sr.iconString = "ic_quotes" as String
            return sr
        case Constants().PFI:
            sr.iconString = "ic_wifi" as String
            return sr
        case Constants().POS:
            sr.iconString = "ic_pos" as String
            return sr
        case Constants().PTO:
            sr.iconString = "ic_facebook" as String
            return sr
        case Constants().RECEBAMAIS:
            sr.iconString = "ic_cards" as String
            return sr
        case Constants().SIGO:
            sr.iconString = "ic_geo" as String
            return sr
        case Constants().SITE:
            sr.iconString = "ic_monitor" as String
            return sr
        case Constants().SKYLINE:
            sr.iconString = "ic_card" as String
            return sr
        case Constants().STAR:
            sr.iconString = "ic_store" as String
            return sr
        case Constants().STC:
            sr.iconString = "ic_warn" as String
            return sr
        case Constants().SUA:
            sr.iconString = "ic_telephone" as String
            return sr
        case Constants().VSC:
            sr.iconString = "ic_smartmachine" as String
            return sr
        default:
            sr.iconString = LegacyCalls().getRandomImage()
            return sr
        }
        
    }
    
}
