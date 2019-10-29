//
//  HalfPieScore.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 10/09/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI
import Charts

struct HorizontalBarIssues: View {
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 50)
            .frame(width: 350, height: 400, alignment: .center)
            .padding(Edge.Set.top, 20)
            .shadow(radius: 10)
        
    }
}
