//
//  CodeInspectionView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 16/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct DefectsView: View {
    
    let scoreResult: ScoreResult
    
    var body: some View {
        
        VStack {
            CategoryTypeView(title: "Defeitos")
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Defeitos abertos").bold().font(.largeTitle)
                    }
                    
                    HStack {
                       Text("Aging (dias)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                      Text("Total de defeitos").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Fix time (dias)").bold().font(.largeTitle)
                    }
                }
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        Text("\(scoreResult.openDefects)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.averageAge))").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(scoreResult.totalDefects)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.averageTimeFix))").bold().font(.largeTitle)
                    }
                }
            }
        }
    }
}
