//
//  RankingView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct RankingView: View {
    var body: some View {
        
        VStack {
            Image("ic_trophy_background")
                .resizable()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 350)
            
            List {
                HStack {
                Text("1")
                    .font(.largeTitle)
                    Image("ic_handshake")
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("System Name")
                        .padding(.leading, 20)
                    Text("4.6")
                        .padding(.leading, 60)
                    Image("ic_goldmedal")
                        .resizable()
                        .frame(width: 50, height: 70)
                        .padding(.leading, 30)
                        .padding(.bottom)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }
        
    }
}

@available(iOS 13.0, *)
struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
