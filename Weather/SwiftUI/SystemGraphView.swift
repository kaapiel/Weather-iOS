//
//  SystemGraphIView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 13.0, *)
struct SystemGraphView: View {
    
    let scoreResult: ScoreResult
    @EnvironmentObject var calls: HttpCalls
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                SystemHeaderView(sr: scoreResult)
                
                ScrollView {
                    
                    VStack {
                        
                        HalfPieChartViewRepresentable(scoreResult: scoreResult).frame(width: 400, height: 400).padding().background(Color.clear).offset(x: -5, y: -60)
                        
                        Text("\(String(format: "%.2f", scoreResult.score))\nScore").font(.largeTitle).offset(y: -360).multilineTextAlignment(.center)
                        
                        LineChartViewRepresentable(scoreHistory: calls.getSystemHistory(sysName: scoreResult.applicationName)).frame(width: 400, height: 300).padding().background(Color.clear).offset(x: -5, y: -390)
                        
                        CodeInspectionView(scoreResult: scoreResult).padding().offset(y: -490)
                        
                        BarChartViewRepresentable(scoreResult: scoreResult).frame(width: 400, height: 300).padding().background(Color.clear).offset(x: -5, y: -490)
                        
                        HorizontalBarChartViewRepresentable(scoreResult: scoreResult).frame(width: 400, height: 300).padding().background(Color.clear).offset(x: -5, y: -490)
                        
                        FunctionalTestsView(scoreResult: scoreResult).padding().offset(y: -490)
                        
                        DefectsView(scoreResult: scoreResult).padding().offset(y: -490)
                        
                        FunctionalEfficiencyView(scoreResult: scoreResult).padding().offset(y: -490)
                    }.padding(.bottom, -480)
                    
                }.padding(.top, -100).background(Color.clear)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
