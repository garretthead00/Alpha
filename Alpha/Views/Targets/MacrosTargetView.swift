//
//  MacrosTargetView.swift
//  Alpha
//
//  Created by Garrett Head on 11/13/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class MacrosTargetView: UITableViewCell {

    @IBOutlet weak var proteinSlider: UISlider!
    @IBOutlet weak var fatSlider: UISlider!
    @IBOutlet weak var carbohydrateSlider: UISlider!
    
    @IBOutlet weak var proteinValueLabel: UILabel!
    @IBOutlet weak var fatValueLabel: UILabel!
    @IBOutlet weak var carbohydrateValueLabel: UILabel!
    
    var energyConsumed : Double?
    var protein : Double? { didSet { updateView() } }
    var fat : Double? { didSet { updateView() } }
    var carbohydrate : Double? { didSet { updateView() } }
    
    
    var proteinPercent : Double {
        let energy = energyConsumed
        return energy! > 0 ? ((protein ?? 0.0) / energy!) * 100 : 0.0
    }
    var fatPercent : Double {
        let energy = energyConsumed
        return energy! > 0 ? ((fat ?? 0.0) / energy!) * 100 : 0.0
    }
    var carbsPercent : Double {
        let energy = energyConsumed
        return energy! > 0 ? ((carbohydrate ?? 0.0) / energy!) * 100 : 0.0
    }
    var sum : Double {
        return proteinPercent + fatPercent + carbsPercent
    }
    
    var nutritionTargets : [UserTarget]? {
        didSet {
            updateView()
        }
    }
    
    var delegate : UserTargetDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        proteinSlider.minimumValue = 0
        proteinSlider.maximumValue = 100
        fatSlider.minimumValue = 0
        fatSlider.maximumValue = 100
        carbohydrateSlider.minimumValue = 0
        carbohydrateSlider.maximumValue = 100
        proteinValueLabel.text = ""
        fatValueLabel.text = ""
        carbohydrateValueLabel.text = ""
    }

    private func updateView(){
        
        proteinSlider.isEnabled = isEditing
        fatSlider.isEnabled = isEditing
        carbohydrateSlider.isEnabled = isEditing
        if sum != 100 {
            proteinValueLabel.textColor = .systemRed
            carbohydrateValueLabel.textColor = .systemRed
            fatValueLabel.textColor = .systemRed
        } else {
            proteinValueLabel.textColor = .label
            carbohydrateValueLabel.textColor = .label
            fatValueLabel.textColor = .label
        }
        proteinSlider.value = Float(proteinPercent)
        proteinValueLabel.text = "\(Int(proteinPercent)) %"
        fatSlider.value = Float(fatPercent)
        fatValueLabel.text = "\(Int(fatPercent)) %"
        carbohydrateSlider.value = Float(carbsPercent)
        carbohydrateValueLabel.text = "\(Int(carbsPercent)) %"
    }
    
    private func sumMacros(){
        if let protein = protein, let fat = fat, let carbs = carbohydrate {
            if sum == 100 { delegate?.updateMacros(protein: protein, fat: fat, carbs: carbs, sum: sum) }
        }
    }
    
    @IBAction func proteinSlider_DidChange(_ sender: Any) {
        let value = Double(proteinSlider.value).rounded(.up)
        let delta = value - proteinPercent
        protein = energyConsumed! * value / 100
        sumMacros()
        if sum >= 100 {
            let fatWeight = fatSlider.value / (fatSlider.value + carbohydrateSlider.value)
            let carbohydrateWeight = carbohydrateSlider.value / (fatSlider.value + carbohydrateSlider.value)
            fat! +=  energyConsumed! * (Double(-fatWeight) * delta) / 100
            carbohydrate! += energyConsumed! * (Double(-carbohydrateWeight) * delta) / 100
            sumMacros()
        }
    }
    
    @IBAction func fatSlider_DidChange(_ sender: Any) {
        let value = Double(fatSlider.value).rounded(.up)
        let remaining = calculateRemaining(fromSliderValues: [proteinSlider.value, fatSlider.value])
        fat = energyConsumed! * value / 100
        carbohydrate = energyConsumed! * remaining / 100
        sumMacros()
    }
    
    @IBAction func carbohydrateSlider_DidChange(_ sender: Any) {
        let value = Double(carbohydrateSlider.value).rounded(.up)
        let remaining = calculateRemaining(fromSliderValues: [proteinSlider.value, carbohydrateSlider.value])
        carbohydrate = energyConsumed! * value / 100
        fat = energyConsumed! * remaining / 100
        sumMacros()
    }
    
    private func calculateRemaining(fromSliderValues values: [Float]) -> Double {
        return Double((100 - (values[0] + values[1])))
    }
}
