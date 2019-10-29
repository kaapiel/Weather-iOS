//
//  ScoreHistory.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 03/09/19.
//  Copyright © 2019 Cielo. All rights reserved.
//
//   let scoreResult = try? newJSONDecoder().decode(ScoreResult.self, from: jsonData)

import Foundation

struct ScoreHistory: Codable {
    
    var sysName: String
    var scoreHistoryUnit: [ScoreHistoryUnit]
    
}
