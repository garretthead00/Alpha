//
//  testHydrationView.swift
//  Alpha
//
//  Created by Garrett Head on 12/26/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import Charts

class HydrationView: UITableViewCell {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    var viewModel : HydrationViewModel? { didSet { updateView() } }
    var chartDataSet = PieChartDataSet()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressLabel.text = ""
        self.chartDataSet.sliceSpace = 0.0
        self.chartDataSet.xValuePosition = .insideSlice
        self.chartDataSet.yValuePosition = .insideSlice
        self.chartDataSet.drawValuesEnabled = false
        self.chartDataSet.useValueColorForLine = false
        self.chartDataSet.valueLineColor = UIColor.clear
        self.chartDataSet.valueLinePart1Length = -0.2
        self.chartDataSet.valueLinePart2Length = -0.1
        self.chartDataSet.label = nil
        self.chartDataSet.selectionShift = 0
        
        self.setupCharts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    private func updateView(){
        if let vm = self.viewModel {
            
            let colors = vm.remaining <= 0.0 ? [UIColor.systemBlue] : [UIColor.systemBlue,UIColor.systemBlue.withAlphaComponent(0.5)]
            self.progressLabel.textColor = colors[0]
            progressLabel.text = "\(Int(vm.percentProgress)) %"
            chartDataSet.colors = colors
            let pieChartDataEntry = PieChartDataEntry(value: (vm.percentProgress))
            let remainingPieChartDataEntry = PieChartDataEntry(value: vm.remaining)
            self.chartDataSet.replaceEntries([pieChartDataEntry,remainingPieChartDataEntry])
            let chartData = PieChartData(dataSet: chartDataSet)
            self.pieChart.data = chartData
        }
    }
    
    private func setupCharts(){
        self.pieChart.noDataText = "..."
        self.pieChart.legend.enabled = false
        self.pieChart.drawHoleEnabled = true
        self.pieChart.holeColor = NSUIColor.systemBackground
        self.pieChart.drawSlicesUnderHoleEnabled = true
        self.pieChart.usePercentValuesEnabled = false
        self.pieChart.holeRadiusPercent = 0.75
        self.pieChart.animate(xAxisDuration: 1.25, yAxisDuration: 1.25)
        
    }
}
