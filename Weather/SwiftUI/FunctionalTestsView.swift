//
//  CodeInspectionView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 16/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct FunctionalTestsView: View {
    
    let scoreResult: ScoreResult
    
    var body: some View {
        
        VStack {
            CategoryTypeView(title: "Testes Funcionais")
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Casos de teste").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Total execuções").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Execuções OK").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Taxa de sucesso").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("Densidade def.").bold().font(.largeTitle)
                    }
                }
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        Text("\(scoreResult.testsCase.roundedWithAbbreviations)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(scoreResult.totalTestExecutions.roundedWithAbbreviations)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(scoreResult.executionsPassed.roundedWithAbbreviations)").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.successRate))%").bold().font(.largeTitle)
                    }
                    
                    HStack {
                        Text("\(String(format: "%.2f", scoreResult.defectsDensity))%").bold().font(.largeTitle)
                    }
                }
            }
        }
    }
}
