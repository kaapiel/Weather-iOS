//
//  SideMenuView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 20/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SideMenuView: View {
    
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    @EnvironmentObject var calls: HttpCalls
    
    var body: some View {
        ZStack {
               GeometryReader { _ in
                   EmptyView()
               }
               .background(Color.gray.opacity(0.3))
               .opacity(self.isOpen ? 1.0 : 0.0)
               .animation(Animation.easeIn.delay(0.25))
               .onTapGesture {
                   self.menuClose()
               }
            
            HStack {
                MenuContentView(name: self.calls.jiraUser!.displayName)
                    .frame(width: self.width)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)

                Spacer()
            }
        }
    }
}
