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
struct HalfPieChartViewRepresentable: UIViewControllerRepresentable {
    
    let scoreResult: ScoreResult
    
    func makeUIViewController(context: Context) -> HalfPieChartViewController {
    
        let controller = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "HalfPieChartViewController")
        
        let viewController = controller as! HalfPieChartViewController
        viewController.scoreResult = scoreResult
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: HalfPieChartViewController, context: Context) {
        
    }
    
}
