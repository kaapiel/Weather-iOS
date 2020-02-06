//
//  HalfPieChartView.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 12/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
struct HorizontalBarChartViewRepresentable: UIViewControllerRepresentable {
    
    let scoreResult: ScoreResult
    
    func makeUIViewController(context: Context) -> HorizontalBarChartViewController {
        
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "HorizontalBarChartViewController")
        
        let viewController = controller as! HorizontalBarChartViewController
        viewController.scoreResult = scoreResult
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: HorizontalBarChartViewController, context: Context) {
        
    }
    
}
