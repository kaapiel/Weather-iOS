//
//  CodeInspectionView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 16/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct FunctionalEfficiencyView: View {
    
    let scoreResult: ScoreResult
    
    var body: some View {
        
        VStack {
            CategoryTypeView(title: "Eficácia funcional")
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Problemas").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Incidentes").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Eficiência").bold().font(.largeTitle)
                    }
                    
                }
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        Text("\(scoreResult.totalProblems)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("N/A").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.effectiveness))%").bold().font(.largeTitle)
                    }
                }
            }
        }
    }
}
