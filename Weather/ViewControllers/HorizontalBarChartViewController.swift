//
//  HorizontalBarChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//
import UIKit
import Charts

class HorizontalBarChartViewController: DemoBaseViewController {

    var scoreResult: ScoreResult!
    @IBOutlet var horizontalBarChartView: HorizontalBarChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Horizontal Bar Char"
        self.options = [.toggleValues,
                        .toggleIcons,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
        self.setup(barLineChartView: horizontalBarChartView)

        horizontalBarChartView.backgroundColor = NSUIColor.clear
        
        horizontalBarChartView.delegate = self
        
        horizontalBarChartView.drawBarShadowEnabled = false
        horizontalBarChartView.drawValueAboveBarEnabled = true
        
        horizontalBarChartView.maxVisibleCount = 60
        
        let xAxis = horizontalBarChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        
        let leftAxis = horizontalBarChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0

        let rightAxis = horizontalBarChartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0

        let l = horizontalBarChartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
//        horizontalBarChartView.legend = l
        horizontalBarChartView.fitBars = true

        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: horizontalBarChartView.xAxis.valueFormatter!)
        marker.chartView = horizontalBarChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        horizontalBarChartView.marker = marker
        
        self.updateChartData()
        
        horizontalBarChartView.animate(yAxisDuration: 2.5)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            horizontalBarChartView.data = nil
            return
        }
        
        self.setDataCount()
    }
    
    func setDataCount() {
        
        var yVals: [BarChartDataEntry] = []
        
        yVals.append(BarChartDataEntry(x: 0*10.0, y: Double(scoreResult!.issuesCodeSmell), data: "Code smell"))
        yVals.append(BarChartDataEntry(x: 1*10.0, y: Double(scoreResult!.issuesVulnerability), data: "Vulnerability"))
        yVals.append(BarChartDataEntry(x: 2*10.0, y: Double(scoreResult!.issuesBug), data: "Bug"))
        
        let set1 = BarChartDataSet(entries: yVals, label: "Issues por Tipo")
        set1.drawIconsEnabled = false
        set1.drawValuesEnabled = false
        set1.colors = DemoBaseViewController.empresaColors()
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = 9.0
        
        horizontalBarChartView.data = data
    }

    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: horizontalBarChartView)
    }
}
