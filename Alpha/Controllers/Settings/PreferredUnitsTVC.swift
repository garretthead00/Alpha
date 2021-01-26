//
//  PreferredUnitsTVC.swift
//  Alpha
//
//  Created by Garrett Head on 1/25/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

protocol UnitDelegate {
    func updateUnits(forKey key: String, withUnit unit: Unit)
}

class PreferredUnitsTVC: UITableViewController {

    let unitDictionary : [String : [Unit]] = [
        "Weight" : [UnitMass.kilograms, UnitMass.pounds],
        "Height" : [UnitLength.centimeters, UnitLength.inches, UnitLength.feet],
        "Distance": [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        "Energy" : [UnitEnergy.kilocalories, UnitEnergy.calories],
        "Volume" : [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.fluidOunces, UnitVolume.cups],
        "Macros" : [UnitMass.grams, UnitMass.ounces],
        "Nutrition" : [UnitMass.grams, UnitMass.milligrams, UnitMass.micrograms],
        "Time" : [UnitDuration.minutes, UnitDuration.hours]
        
    ]
    var preferredUnits : [String : String] = [:]
    var keys : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keys = Array(unitDictionary.keys)
        loadPreferredUnits()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return unitDictionary.keys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredUnitView", for: indexPath) as! PreferredUnitView
        cell.name = keys![indexPath.row]
        cell.items = unitDictionary[keys![indexPath.row]]
        cell.preferredUnit = preferredUnits[keys![indexPath.row]]
        cell.delegate = self
        return cell
    }
}

// MARK: - API
extension PreferredUnitsTVC {
    private func loadPreferredUnits(){
        for key in keys! {
            API.PreferredUnits.observePreferredUnit(forKey: key, completion: {
                unit in
                self.preferredUnits[key] = unit
                self.tableView.reloadData()
            })
        }
    }
}

// MARK: - UnitDelegate
extension PreferredUnitsTVC : UnitDelegate {
    func updateUnits(forKey key: String, withUnit unit: Unit) {
        API.PreferredUnits.updatePreferredUnits(withKey: key, value: unit.symbol)
    }
}
