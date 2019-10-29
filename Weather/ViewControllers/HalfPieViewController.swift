//
//  HalfPieChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//
import Charts
import UIKit

class HalfPieChartViewController: DemoBaseViewController {
    
    var scoreResult: ScoreResult!
    @IBOutlet var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Half Pie Chart"
        
        self.options = [.toggleValues,
                        .toggleXValues,
                        .togglePercent,
                        .toggleHole,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .drawCenter,
                        .saveToGallery,
                        .toggleData]
        
        self.setup(pieChartView: chartView)
        
        chartView.delegate = self
        
        chartView.backgroundColor = NSUIColor.clear
        
        chartView.legend.enabled = false
        
        chartView.holeColor = .clear
        chartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0)
        chartView.holeRadiusPercent = 0.55
        chartView.rotationEnabled = false
        chartView.highlightPerTapEnabled = true
        
        chartView.maxAngle = 180 // Half chart
        chartView.rotationAngle = 180 // Rotate to make the half on the upper side
        chartView.centerTextOffset = CGPoint(x: 0, y: 0)
        
        // entry label styling
        chartView.entryLabelColor = .white
        chartView.entryLabelFont = UIFont(name:"HelveticaNeue-Light", size:12)!
        
        self.updateChartData()
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(2, range: 5)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        var entries = Array<PieChartDataEntry>()
        entries.append(PieChartDataEntry(value: scoreResult.score)) // Set scores here
        entries.append(PieChartDataEntry(value: 5 - scoreResult.score))
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.sliceSpace = 3
        set.selectionShift = 10
        set.colors = [
            NSUIColor(red: 0/255.0, green: 171/255.0, blue: 239/255.0, alpha: 1.0),
            NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 3
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = ""
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 20)!)
        data.setValueTextColor(.white)
        
        chartView.data = data
        
        chartView.setNeedsDisplay()
    }
    
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleXValues:
            chartView.drawEntryLabelsEnabled = !chartView.drawEntryLabelsEnabled
            chartView.setNeedsDisplay()
            
        case .togglePercent:
            chartView.usePercentValuesEnabled = !chartView.usePercentValuesEnabled
            chartView.setNeedsDisplay()
            
        case .toggleHole:
            chartView.drawHoleEnabled = !chartView.drawHoleEnabled
            chartView.setNeedsDisplay()
            
        case .drawCenter:
            chartView.drawCenterTextEnabled = !chartView.drawCenterTextEnabled
            chartView.setNeedsDisplay()
            
        case .animateX:
            chartView.animate(xAxisDuration: 1.4)
            
        case .animateY:
            chartView.animate(yAxisDuration: 1.4)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
            
        case .spin:
            chartView.spin(duration: 2,
                           fromAngle: chartView.rotationAngle,
                           toAngle: chartView.rotationAngle + 360,
                           easingOption: .easeInCubic)
            
        default:
            handleOption(option, forChartView: chartView)
        }
    }
}
