//
//  MacroTargetMenuController.swift
//  Alpha
//
//  Created by Garrett Head on 1/23/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit
import Charts

class MacroTargetMenuController: UIViewController {

    var delegate : TargetDelegate?
    var viewModels : [ActivityTargetHandlerViewModel]?
    
    // MARK: Nutrition Properties
    var energyConsumedHandler : ActivityTargetHandlerViewModel?
    var proteinHandler : ActivityTargetHandlerViewModel?
    var fatHandler : ActivityTargetHandlerViewModel?
    var carbohydratesHandler : ActivityTargetHandlerViewModel?
    var macroSum : Double = 0.0
    var proteinPercent : Double = 0.0
    var fatPercent : Double = 0.0
    var carbohydratePercent : Double = 0.0
    
    // MARK: IBActions and Outlets
    @IBOutlet weak var pieChart: PieChartView!
    @IBAction func cancelButton_Tapped(_ sender: Any) { self.dismiss(animated: true, completion: nil) }
    @IBAction func saveButton_Tapped(_ sender: Any) { saveMacros() }
    @IBAction func energyTextField_EditingDidEnd(_ sender: Any) { updateEnergy() }
    @IBAction func energyTextField_EditingDidDegin(_ sender: Any) { toggleEnergyLabel() }
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var proteinSlider: UISlider!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatSlider: UISlider!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydratesSlider: UISlider!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBAction func proteinSlider_DidChange(_ sender: Any) { updateProteinTarget() }
    @IBAction func fatSlider_DidChange(_ sender: Any) { updateFatTarget() }
    @IBAction func carbohydratesSlider_DidChange(_ sender: Any) { updateCarbohydratesTarget() }
    
    
    var chartDataSet = PieChartDataSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Sliders
        proteinSlider.minimumValue = 0
        proteinSlider.maximumValue = 100
        fatSlider.minimumValue = 0
        fatSlider.maximumValue = 100
        carbohydratesSlider.minimumValue = 0
        carbohydratesSlider.maximumValue = 100
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { view.endEditing(true) }
}

extension MacroTargetMenuController {
    private func updateView() {
        if let viewModels = self.viewModels {
            energyConsumedHandler = viewModels.first(where: { $0.identifier == .EnergyConsumed})
            proteinHandler = viewModels.first(where: { $0.identifier == .Protein})
            fatHandler = viewModels.first(where: { $0.identifier == .Fat})
            carbohydratesHandler = viewModels.first(where: { $0.identifier == .Carbohydrates})
            
             let energyTarget = energyConsumedHandler!.value
               let preferredUnit = energyConsumedHandler!.unit
               let proteinTarget = proteinHandler!.value
               let fatTarget = fatHandler!.value
               let carbohydratesTarget = carbohydratesHandler!.value
                energyTextField.text = "\(Int(energyTarget)) \(preferredUnit.symbol)"
                
                proteinPercent = energyTarget > 0 ? (proteinTarget / energyTarget) * 100 : 0
                fatPercent = energyTarget > 0 ? (fatTarget / energyTarget) * 100 : 0
                carbohydratePercent = energyTarget > 0 ? (carbohydratesTarget / energyTarget) * 100 : 0
                let sum = proteinPercent + fatPercent + carbohydratePercent
                proteinLabel.textColor = sum != 100 ? .systemRed : .label
                fatLabel.textColor = sum != 100 ? .systemRed : .label
                carbohydratesLabel.textColor = sum != 100 ? .systemRed : .label
                proteinLabel.text = "\(Int(proteinPercent)) %"
                fatLabel.text = "\(Int(fatPercent)) %"
                carbohydratesLabel.text = "\(Int(carbohydratePercent)) %"
                proteinSlider.value = Float(proteinPercent)
                fatSlider.value = Float(fatPercent)
                carbohydratesSlider.value = Float(carbohydratePercent)
                chartDataSet.removeAll()
                chartDataSet.append(contentsOf: [PieChartDataEntry(value: proteinTarget), PieChartDataEntry(value: fatTarget), PieChartDataEntry(value: carbohydratesTarget)])
                let colors = [UIColor.systemRed, UIColor.systemTeal, UIColor.systemYellow]
                chartDataSet.colors = colors
                let chartData = PieChartData(dataSet: chartDataSet)
                pieChart.data = chartData
        }
    }
    
    
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
}

extension MacroTargetMenuController {
    private func updateProteinTarget(){
        let value = proteinSlider.value.rounded(.up)
        let delta = Double(value) - proteinPercent
        print("sliderValue: \(value) with a delta of: \(delta)")
        proteinPercent = Double(value)
        fatPercent += (delta/2).rounded(.up)
        carbohydratePercent = 100 - (proteinPercent + fatPercent)
        setTargets()
        
    }
    
    private func updateFatTarget(){
        let value = fatSlider.value.rounded(.up)
        let remaining = 100 - (proteinPercent + fatPercent)
        fatPercent = Double(value)
        carbohydratePercent = remaining
        setTargets()
    }
    private func updateCarbohydratesTarget(){
        let value = carbohydratesSlider.value.rounded(.up)
        let remaining = 100 - (proteinPercent + carbohydratePercent)
        carbohydratePercent = Double(value)
        fatPercent = remaining
        setTargets()
    }
    
    private func setTargets(){
        let energyTarget = energyConsumedHandler!.value
        let proteinValue = energyTarget * proteinPercent / 100
        let fatValue = energyTarget * fatPercent / 100
        let carbValue = energyTarget * carbohydratePercent / 100
        print("setTargets: protein - \(proteinValue)    fats - \(fatValue)     carbs - \(carbValue)")
        proteinHandler!.value = proteinValue > 0 ? proteinValue.rounded(.down) : 0
        fatHandler!.value = fatValue > 0 ? fatValue.rounded(.down) : 0
        carbohydratesHandler!.value = carbValue > 0 ? carbValue.rounded(.down) : 0
        refreshViewModels()
    }
    
    private func refreshViewModels(){
        viewModels?.removeAll()
        viewModels!.append(contentsOf: [energyConsumedHandler!, proteinHandler!, fatHandler!, carbohydratesHandler!])
        updateView()
    }
    
    private func saveMacros(){
        let sum = Int(proteinPercent + fatPercent + carbohydratePercent)
        if sum == 100 {
            delegate?.updateMacros(viewModels: [energyConsumedHandler!, proteinHandler!, fatHandler!, carbohydratesHandler!])
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateEnergy(){
        if let input = energyTextField.text,
            let energy = Double(input) {
            energyConsumedHandler!.value = energy
            setTargets()
        }
    }
    
    private func toggleEnergyLabel() { energyTextField.text = "\(Int(energyConsumedHandler!.value))" }
}

