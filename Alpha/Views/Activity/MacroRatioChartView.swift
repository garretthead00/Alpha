//
//  MacroRatioChartView.swift
//  Alpha
//
//  Created by Garrett Head on 2/7/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit
import Charts

class MacroRatioChartView: UITableViewCell {

    @IBOutlet weak var pieChart: PieChartView!
    
    var viewModel : MacroRatioChartViewModel? { didSet { updateView() } }
    var chartDataSet = PieChartDataSet()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Setup ChartDataSet
        chartDataSet.sliceSpace = 0.0
        chartDataSet.xValuePosition = .insideSlice
        chartDataSet.yValuePosition = .insideSlice
        chartDataSet.drawValuesEnabled = false
        chartDataSet.useValueColorForLine = false
        chartDataSet.valueLineColor = UIColor.clear
        chartDataSet.valueLinePart1Length = -0.2
        chartDataSet.valueLinePart2Length = -0.1
        chartDataSet.label = nil
        chartDataSet.selectionShift = 0
        setupCharts()
    }
    
}

extension MacroRatioChartView {
    private func setupCharts() {
        pieChart.noDataText = "..."
        pieChart.legend.enabled = false
        pieChart.drawHoleEnabled = false
        pieChart.holeColor = NSUIColor.black
        pieChart.drawSlicesUnderHoleEnabled = true
        pieChart.usePercentValuesEnabled = false
        pieChart.holeRadiusPercent = 0.0
        pieChart.animate(xAxisDuration: 1.25, yAxisDuration: 1.25)
        updateView()
    }

    private func updateView() {
        
        
        if let vm = self.viewModel {
            chartDataSet.removeAll()
            chartDataSet.append(contentsOf: [PieChartDataEntry(value:vm.proteinPercent), PieChartDataEntry(value: vm.fatPercent), PieChartDataEntry(value: vm.carbohydratePercent)])
            let colors = [UIColor.systemRed, UIColor.systemTeal, UIColor.systemYellow]
            chartDataSet.colors = colors
            let chartData = PieChartData(dataSet: chartDataSet)
            pieChart.data = chartData
        }
    }
    
}
