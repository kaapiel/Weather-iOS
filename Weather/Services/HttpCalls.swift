//
//  MongoDBCall.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 30/08/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import MongoKitten
import Combine

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSinceReferenceDate: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}

@available(iOS 13.0, *)
class HttpCalls: ObservableObject {
 
    @Published var scoreResults: Array<ScoreResult> = Array()
    @Published var actualSysName: String = "Carregando"
    @Published var history: ScoreHistory?
    @Published var qttSystems = 17
    @Published var historySearch = 10
    @Published var load = false
    @Published var jiraUser: JiraUser?
    @Published var finished: Bool = false
    
    let mongoIp = "10.82.252.152"
    let mongoPort = "27017"
    let mongoUser = "developer"
    let mongoPass = "C!elo_dev"
    let mongoConnectionPrefix = "mongodb://"
    let mongoDB = "dev-test"
    let mongoScoreCollection = "score"
    
    @Published var images: [String] = ["ic_heart", "ic_3g", "ic_12x", "ic_48x", "ic_bulb", "ic_calendar", "ic_card", "ic_cards", "ic_cash", "ic_check", "ic_cloud_extract", "ic_delivery", "ic_ecommerce", "ic_facebook", "ic_flag", "ic_geo", "ic_gift", "ic_handshake", "ic_happy", "ic_infinity", "ic_law", "ic_lighthouse", "ic_lio", "ic_lock", "ic_monitor", "ic_no_cash", "ic_percent", "ic_plane", "ic_play", "ic_pos", "ic_push", "ic_quotes", "ic_receive_cash", "ic_return", "ic_right", "ic_search", "ic_smartmachine", "ic_store", "ic_talk", "ic_telephone", "ic_user", "ic_warn", "ic_wifi", "icon_lio_v2"]
    
    func callMongo() -> [ScoreResult] {
        
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
                        
                        DispatchQueue.main.async {
                            self.scoreResults.append(scoreResult)
                            self.actualSysName = self.scoreResults[self.scoreResults.count-1].applicationName
                            print("\(scoreResult.applicationName) \(self.scoreResults.count)")
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            } catch {
                print(error)
                self.actualSysName = "Aconteceu um erro na base de dados 😫. Vamos fechar o aplicativo e voce tenta de novo, ok?"
            }
        }
        return scoreResults
    }
    
    func getLastUpdatedSystems() -> Array<ScoreResult> {
        return Array(scoreResults.suffix(qttSystems))
    }
    
    func getIssuesSum() -> String {
        let systems = Array(scoreResults.suffix(qttSystems))
        var issues: Int = 0
        
        for sr in systems {
            issues += sr.totalIssues
        }
        return issues.roundedWithAbbreviations
        
    }
    
    func getLinesSum() -> String {
        let systems = Array(scoreResults.suffix(qttSystems))
        var lines: Int = 0
        
        for sr in systems {
            lines += sr.ncloc
        }
        return lines.roundedWithAbbreviations
    }
    
    func getLastUpdated() -> String {
        let systems = Array(scoreResults.suffix(qttSystems))
        return systems[0].id.getDateStringFromUTC()
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
    
    func getSystemHistory(sysName: String) -> ScoreHistory {
        
        var scoreHistoryUnit: [ScoreHistoryUnit] = []
        var scoreHistory = ScoreHistory(sysName: "SysName", scoreHistoryUnit: scoreHistoryUnit)
        
        for sr in scoreResults {
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
    
    func getJiraUser(email: String) -> JiraUser? {
                
        guard let url = URL(string: "https://jiracielo.atlassian.net/rest/api/latest/user?username=\(email.split(separator: "@")[0])") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic dDIxMDZyc25AcHJlc3RhZG9yY2JtcC5jb20uYnI6R3FGMzZrNVI4ZDJWUzVna1VjSVpCMjE3", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            let jiraUser = try! JSONDecoder().decode(JiraUser.self, from: data)
            
            DispatchQueue.main.async {
                self.jiraUser = jiraUser
            }
            
        }.resume()
        
        return jiraUser
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
    
}
