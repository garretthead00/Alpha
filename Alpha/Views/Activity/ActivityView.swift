//
//  ActivityView.swift
//  Alpha
//
//  Created by Garrett Head on 12/10/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import Charts

class ActivityView: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var pieChart: PieChartView!
    var chartDataSet = PieChartDataSet()
    
    var activityViewModel : ActivityViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        iconImageView.image = nil
        progressLabel.text = ""
        remainingLabel.text = ""
        
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
    
    private func setupCharts(){
        self.pieChart.noDataText = "..."
        self.pieChart.legend.enabled = false
        self.pieChart.drawHoleEnabled = true
        self.pieChart.holeColor = NSUIColor.systemBackground
        self.pieChart.drawSlicesUnderHoleEnabled = true
        self.pieChart.usePercentValuesEnabled = false
        self.pieChart.holeRadiusPercent = 0.9
        self.pieChart.animate(xAxisDuration: 1.25, yAxisDuration: 1.25)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView(){
        if let vm = activityViewModel {
            self.nameLabel.text = vm.name
            self.iconImageView.image = vm.icon
            let colors = vm.remaining <= 0.0 ? [vm.color] : [vm.color,vm.color.withAlphaComponent(0.5)]
            self.progressLabel.textColor = colors[0]
            progressLabel.text = "\(Int(vm.progress)) / \(Int(vm.target)) \(vm.unit ?? "")"
            remainingLabel.text = vm.remaining > 0 ? "\(Int(vm.remaining)) \(vm.unit ?? "") left to goal" : "Completed!"
            chartDataSet.colors = colors
            let pieChartDataEntry = PieChartDataEntry(value: (vm.progress))
            let remainingPieChartDataEntry = PieChartDataEntry(value: vm.remaining)
            self.chartDataSet.replaceEntries([pieChartDataEntry,remainingPieChartDataEntry])
            let chartData = PieChartData(dataSet: chartDataSet)
            self.pieChart.data = chartData
            
        }
    }

}
