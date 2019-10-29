//
//  LineChartFilledViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//
import UIKit
import Charts

class LineChartViewController: DemoBaseViewController {
    
    var scoreHistory: ScoreHistory!
    @IBOutlet var lineView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Filled Line Chart"
        
        lineView.delegate = self
        
        lineView.backgroundColor = NSUIColor.clear
        lineView.gridBackgroundColor = NSUIColor.clear
        lineView.drawGridBackgroundEnabled = false
        
        lineView.drawBordersEnabled = true
        
        lineView.chartDescription?.enabled = true
        
        lineView.chartDescription?.font.withSize(100)
        lineView.chartDescription?.text = "Histórico do sistema"
        
        lineView.pinchZoomEnabled = false
        lineView.dragEnabled = true
        lineView.setScaleEnabled(true)
        lineView.legend.enabled = false
        lineView.xAxis.enabled = true
        
        let leftAxis = lineView.leftAxis
        leftAxis.axisMaximum = 6
        leftAxis.axisMinimum = -1
        leftAxis.drawAxisLineEnabled = false
        
        lineView.rightAxis.drawAxisLineEnabled = false
        lineView.rightAxis.enabled = false
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: lineView.xAxis.valueFormatter!)
        marker.chartView = lineView
        marker.minimumSize = CGSize(width: 80, height: 40)
        lineView.marker = marker
        
        self.updateChartData()
        
        lineView.animate(xAxisDuration: 5, easingOption: .easeOutBack)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            lineView.data = nil
            return
        }
        
        self.setDataCount()
    }
    
    func setDataCount() {
        
        var yVals1: [ChartDataEntry] = []
        var count = 0
        
        for scoreHistoryUnit in scoreHistory.scoreHistoryUnit {
            yVals1.append(ChartDataEntry(x: Double(count), y: scoreHistoryUnit.score, data: scoreHistoryUnit))
            print(scoreHistoryUnit.date.getDateStringFromUTC())
            count += 1
        }
        
        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 1.0))
        set1.drawCirclesEnabled = true
        set1.drawValuesEnabled = true
        set1.setCircleColor(NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0))
        set1.valueTextColor = NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.fillAlpha = 1
        set1.drawFilledEnabled = true
        
        set1.lineDashPhase = 0
        
        let dashedLines: [CGFloat] = [10.0, 5.0]
        set1.lineDashLengths = dashedLines
        
        let colorTop = NSUIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.0).cgColor
        let colorBottom = NSUIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 0.7).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        set1.mode = .cubicBezier
        
        set1.highlightColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.lineView.leftAxis.axisMinimum)
        }
        
        let data = LineChartData(dataSets: [set1])
        data.setDrawValues(true)
        
        lineView.data = data
    }
}
