//
//  ActivityIndicatorRepresentable.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 01/10/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct ActivityIndicatorRepresentable: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorRepresentable>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorRepresentable>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
