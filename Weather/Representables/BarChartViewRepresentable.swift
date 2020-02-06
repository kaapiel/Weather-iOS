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
struct BarChartViewRepresentable: UIViewControllerRepresentable {
    
    let scoreResult: ScoreResult
    
    func makeUIViewController(context: Context) -> BarChartViewController {
        
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "BarChartViewController")
        
        let viewController = controller as! BarChartViewController
        viewController.scoreResult = scoreResult
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: BarChartViewController, context: Context) {
        
    }
    
}
