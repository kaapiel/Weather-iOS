//
//  ScoreHistoryUnit.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 03/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//
//   let scoreResult = try? newJSONDecoder().decode(ScoreResult.self, from: jsonData)

import Foundation

struct ScoreHistoryUnit: Codable {

    var date, score: Double
    
}
