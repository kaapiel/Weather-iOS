//
//  SwiftUIView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 23/08/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
struct LoginView: View {
    
    @EnvironmentObject var calls: HttpCalls
    @State var email: String = "gabriel.fraga@cielo.com.br"
    @State var jiraUser: JiraUser?
    @State var loading: Bool = false
    @State var buttonText: String = "ENTRAR"
    
    var body: some View {
        
        VStack {
            
            Image("ic_launcher_lightblue")
                .resizable()
                .frame(width: 55, height: 50)
                .padding(.trailing, 300)
                .padding(.top, -50)
            
            Image("ic_launcher_white_with_name")
                .resizable()
                .frame(width: 400, height: 300)
                .padding(.top, 50)
                .offset(x: 50)
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    Text("Login Cielo")
                        .colorInvert()
                        .font(.largeTitle)
                    
                    Text("Utilize o email cielo para entrar")
                        .colorInvert()
                        .font(.subheadline)
                    
                    TextField("email@cielo.com.br", text: $email)
                        .colorInvert()
                        .padding(.all)
                        .background(Color.gray)
                    
                    Button(action: {
                        self.jiraUser = self.calls.getJiraUser(email: self.email)
                        self.loading = true
                        self.buttonText = ""
                    }) {
                        //3 clicks to login
                        if self.jiraUser == nil || self.loading == false {
                            ZStack {
                                Text("\(buttonText)")
                                    .foregroundColor(Color.white)
                                    .frame(width: 350, height: 30, alignment: .center)
                                    .padding()
                                    .background(Color.black)
                                ActivityIndicatorRepresentable(isAnimating: .constant(loading), style: .large)
                                    .frame(alignment: .center)
                                    .padding()
                            }
                        } else if self.jiraUser != nil && self.loading == true {
                            NavigationLink(destination: AllSystemsView(calls: self._calls, overallScoreResult: nil)) {
                                ZStack {
                                    Text("\(buttonText)")
                                        .foregroundColor(Color.white)
                                        .frame(width: 350, height: 30, alignment: .center)
                                        .padding()
                                        .background(Color.black)
                                    ActivityIndicatorRepresentable(isAnimating: .constant(loading), style: .large)
                                        .frame(alignment: .center)
                                        .padding()
                                }
                            }
                        }
                    }.padding(.top, 20)
                    
                }.padding().padding(.bottom, 30)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

@available(iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
