//
//  ContentView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SplashView: View {
    
    @EnvironmentObject var calls: HttpCalls
    @State var image = ""
    @State var count = 0
    @State var countScore = 0
    @State var didLoadFinished = false
    @State var loading: Bool = true
    
    let timer = Timer.publish(every: 0.3, on: .current, in: .common).autoconnect()
    var sr: [ScoreResult]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image("ic_launcher_darkblue")
                    .resizable()
                    .frame(width: 110, height: 100)
                    .padding(.top, 200)
                    .onAppear(perform: {
                        _ = self.calls.callMongo()
                    })
                
                if self.$calls.actualSysName.wrappedValue != "Carregando" {
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.top, 200)
                        .onReceive(timer) {_ in
                            self.image = self.calls.images[self.count]
                            self.count += 1
                            if (self.count == self.calls.images.count) {
                                self.count = 0
                            }
                    }.onAppear(perform: {
                        DispatchQueue.main.async {
                            self.loading = false
                        }
                    })
                } else {
                    ActivityIndicatorRepresentable(isAnimating: .constant(loading), style: .large)
                        .frame(alignment: .center)
                        .padding()
                }
                
                
                
                NavigationLink(destination: LoginView()) {
                    Text("\(self.calls.actualSysName)...")
                        .foregroundColor(Color.white)
                }.colorInvert()
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(sr: [ScoreResult].init())
    }
}
