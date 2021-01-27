//
//  CreateHydrationLogController.swift
//  Alpha
//
//  Created by Garrett Head on 1/27/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

class CreateHydrationLogController: UIViewController {

    
    // MARK: IB Outlets and Actions
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var unitPicker: UIPickerView!
    @IBAction func cancelButton_Tapped(_ sender: Any) { cancel() }
    @IBAction func drinkButton_Tapped(_ sender: Any) { drink() }
    
    
    // MARK: Controller Parameters
    var value : Double?
    var unit : Unit?
    var unitOptions : [Unit] = [UnitVolume.liters, UnitVolume.milliliters, UnitVolume.fluidOunces, UnitVolume.cups]
    var delegate : HydrationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitPicker.delegate = self
        unitPicker.dataSource = self

    }
}

//
extension CreateHydrationLogController {
    private func cancel() { self.dismiss(animated: true, completion: nil) }
    private func drink() {
        print("DRINK!")
        if let input = valueTextField.text, let value = Double(input) {
            let row = unitPicker.selectedRow(inComponent: 0)
            let unit = unitOptions[row]
            print("value of \(self.valueTextField.text)selected unit: \(unit.symbol)")
            delegate?.createLog(withValue: value, ofUnit: unit)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension CreateHydrationLogController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitOptions[row].symbol
   }
}
