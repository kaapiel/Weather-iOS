//
//  CategoryTypeView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 16/09/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct CategoryTypeView: View {
    
    var title: String
    
    var body: some View {
        
        VStack {
           
            RoundedRectangle(cornerRadius: 200)
                .frame(width: 350, height: 50, alignment: .center)
                .shadow(radius: 10)
            
            HStack {
                
                Text("\(title)")
                    .colorInvert()
                    .padding(.top, -54)
                    .font(.largeTitle)
            }
        }.padding(.top, 100)
    }
}

@available(iOS 13.0, *)
struct CategoryTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTypeView(title: "")
    }
}
