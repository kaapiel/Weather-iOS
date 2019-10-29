//
//  SystemListItemView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SystemListItemView: View {
    
    @State var scoreResult: ScoreResult
    @EnvironmentObject var calls: HttpCalls
    
    var body: some View {
        
        HStack {
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 150, alignment: .center)
                //.padding(leading, 20)
                .padding()
                .colorInvert()
            Image(self.calls.getRandomImage())
                .resizable()
                .frame(width: 90, height: 90)
                .padding(.leading, -350)
            Text("\(scoreResult.applicationName) - \(String(format: String(scoreResult.score), "%.2f"))")
                .font(.largeTitle)
                .padding(.leading, -260)
            Image(scoreResult.medal ?? "ic_menu")
                .resizable()
                .frame(width: 30, height: 40)
                .padding(.leading, -70)
                .padding(.top, -70)
        }
    }
}
