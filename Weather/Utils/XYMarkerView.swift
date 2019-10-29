//
//  XYMarkerView.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//
import Foundation
import Charts

public class XYMarkerView: BalloonMarker {
    public var xAxisValueFormatter: IAxisValueFormatter
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter) {
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
        super.init(color: color, font: font, textColor: textColor, insets: insets)
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        
        var string: String = ""
        
        if ((entry.data as? ScoreHistoryUnit) != nil) {
            string = "\((String(format: "%.2f", (entry.data as! ScoreHistoryUnit).score))) | \((entry.data as! ScoreHistoryUnit).date.getDateStringFromUTC())"
        } else {
            string = "\(entry.data!)"
        }
        
        setLabel(string)
    }
    
}
