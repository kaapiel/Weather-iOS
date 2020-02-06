//
//  SystemHeaderView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SystemHeaderView: View {
    
    @EnvironmentObject var calls: HttpCalls
    let activityViewController = SwiftUIActivityViewRepresentable()
    let sr: ScoreResult?
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                self.activityViewController.shareImage(uiImage: ShareUtils().takeScreenshot()!)
            }) {
                
                ZStack {
                    Image(systemName:"square.and.arrow.up")
                        .renderingMode(.original)
                        .font(Font.title.weight(.regular))
                        .background(Color.clear)
                    activityViewController.background(Color.clear)
                }
            }.background(Color.clear).frame(width: 50, height: 50).offset(x: 140, y: 30)
            
            Text("\(sr?.applicationName ?? "Overall")").bold()
                .font(.largeTitle)
                .colorInvert()
            
            Text("Atualizado por último em \(calls.getLastUpdated())")
                .font(.subheadline)
                .padding(.top, 0)
                .colorInvert()
            
            RoundedRectangle(cornerRadius: 200)
                .frame(width: 350, height: 100, alignment: .center)
                .padding(.top, 20)
                .shadow(radius: 10)
            
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/20/*@END_MENU_TOKEN@*/)
                .frame(width: 2, height: 70)
                .colorInvert()
                .padding(.top, -92)
            
            HStack {
                
                VStack {
                    Text("\(sr == nil ? calls.getLinesSum() : String(sr!.ncloc.roundedWithAbbreviations))")
                        .padding(.trailing, 20)
                        .padding(.top, -10)
                        .font(.largeTitle)
                        .colorInvert()
                    Text("Lines")
                        .padding(.trailing, 20)
                        .padding(.top, -20)
                        .font(.largeTitle)
                        .colorInvert()
                }
                
                VStack {
                    Text("\(sr == nil ? calls.getIssuesSum() : String(sr!.totalIssues.roundedWithAbbreviations))")
                        .padding(.leading, 30)
                        .padding(.top, -10)
                        .font(.largeTitle)
                        .colorInvert()
                    Text("Issues")
                        .padding(.leading, 15)
                        .padding(.top, -20)
                        .font(.largeTitle)
                        .colorInvert()
                }
                
            }.padding(.top, -90)
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}
