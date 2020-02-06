//
//  CodeInspectionView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 16/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct CodeInspectionView: View {
    
    let scoreResult: ScoreResult
    
    var body: some View {
        
        VStack {
            CategoryTypeView(title: "Inspeção de código")
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Nloc").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Total Issues").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Open Issues").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Coverage").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Duplications").bold().font(.largeTitle)
                    }
                }
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        Text("\(scoreResult.ncloc.roundedWithAbbreviations)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(scoreResult.totalIssues)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(scoreResult.openIssues)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.coverage))%").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.duplicationDensity))%").bold().font(.largeTitle)
                    }
                }
            }
        }
    }
}
