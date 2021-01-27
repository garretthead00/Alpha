//
//  TargetActivityView.swift
//  Alpha
//
//  Created by Garrett Head on 12/11/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import Charts

class TargetActivityView: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var progessLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    var viewModel : ActivityTargetDataViewModel? { didSet { updateView() } }
    var chartDataSet = PieChartDataSet()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup Chart
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

    private func setupCharts(){
        pieChart.noDataText = "..."
        pieChart.legend.enabled = false
        pieChart.drawHoleEnabled = true
        pieChart.holeColor = NSUIColor.black
        pieChart.drawSlicesUnderHoleEnabled = true
        pieChart.usePercentValuesEnabled = false
        pieChart.holeRadiusPercent = 0.75
        pieChart.animate(xAxisDuration: 1.25, yAxisDuration: 1.25)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView(){
        if let vm = viewModel {
            self.nameLabel.text = vm.name
            self.iconImageView.image = vm.icon
            self.progessLabel.text = "\(Int(vm.progress)) \(vm.unit)"
            
            var colors = [UIColor.systemGray, UIColor.systemGray6]
            
            if vm.targetValue > 0 && vm.remaining <= 0.0 {
                colors = [vm.color]
            }
            
            chartDataSet.colors = colors
            let pieChartDataEntry = PieChartDataEntry(value: (vm.progress))
            let remainingPieChartDataEntry = PieChartDataEntry(value: vm.remaining)
            self.chartDataSet.replaceEntries([pieChartDataEntry,remainingPieChartDataEntry])
            let chartData = PieChartData(dataSet: chartDataSet)
            self.pieChart.data = chartData
        }
    }

}
