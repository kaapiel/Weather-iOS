//
//  AllSystemsView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct AllSystemsView: View {
    
    @State var menuOpen: Bool = false
    @EnvironmentObject var calls: HttpCalls
    let sr: [ScoreResult] = []
    let overallScoreResult: ScoreResult?
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                SystemHeaderView(sr: overallScoreResult).edgesIgnoringSafeArea(.all)
                
                HStack {
                    
                    List(self.calls.oderListByScore(scoreResults: self.calls.getLastUpdatedSystems()) ) {sr in
                        NavigationLink(destination: SystemGraphView(scoreResult: sr)) {
                            SystemListItemView(scoreResult: sr)
                        }
                        
                    }.offset(y: -10)
                        .edgesIgnoringSafeArea(.all)
                }
                
            }
            
            if !self.menuOpen {
                Button(action: {
                    self.openMenu()
                }, label: {
                    Image("ic_menu")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .font(Font.title.weight(.regular))
                        .background(Color.clear)
                    })
                    .offset(x: -150, y: -350)
            }
            
            SideMenuView(width: 300,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
                .edgesIgnoringSafeArea(.all)
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
    
}
