//
//  ActivityViewRepresentable.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 18/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct SwiftUIActivityViewRepresentable : UIViewControllerRepresentable {

    let activityViewController = ActivityViewController()

    func makeUIViewController(context: Context) -> ActivityViewController {
        activityViewController
    }
    func updateUIViewController(_ uiViewController: ActivityViewController, context: Context) {
        //
    }
    func shareImage(uiImage: UIImage) {
        activityViewController.uiImage = uiImage
        activityViewController.shareImage()
    }
}
