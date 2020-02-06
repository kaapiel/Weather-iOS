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
struct LineChartViewRepresentable: UIViewControllerRepresentable {
    
    let scoreHistory: ScoreHistory
    
    func makeUIViewController(context: Context) -> LineChartViewController {
    
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "LineChartViewController")
        
        let viewController = controller as! LineChartViewController
        viewController.scoreHistory = scoreHistory
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: LineChartViewController, context: Context) {
        
    }
    
}
