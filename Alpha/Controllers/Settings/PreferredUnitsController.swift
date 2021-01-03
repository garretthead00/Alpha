//
//  PreferredUnitsController.swift
//  Alpha
//
//  Created by Garrett Head on 9/12/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth

let unitOptions : [String] = ["Weight", "Height", "Distance", "Calories", "Volume"]
let weightUnits : [String] = ["lbs", "kg"]
let volumeUnits : [String] = ["fl oz", "mL"]
let heightUnits : [String] = ["in", "cm"]
let distanceUnits : [String] = ["mi", "km"]
let energyUnits : [String] = ["kCal", "kJ"]

class PreferredUnitsController: UITableViewController {


    var preferredUnits : PreferredUnits = PreferredUnits() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var energySegmentedControl: UISegmentedControl!
    @IBOutlet weak var volumeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.PreferredUnits.observePreferredUnits(completion: {
            units in
            self.preferredUnits = units
        })
        updateView()
    }
    
    private func updateView(){
        if let weight = preferredUnits.weight {
            if let index = weightUnits.firstIndex(of: weight) {
               self.weightSegmentedControl.selectedSegmentIndex = index
            } else {
                self.weightSegmentedControl.selectedSegmentIndex = 0
            }
            
        }
        if let height = preferredUnits.height {
            if let index = heightUnits.firstIndex(of: height) {
               self.heightSegmentedControl.selectedSegmentIndex = index
            } else {
                self.heightSegmentedControl.selectedSegmentIndex = 0
            }
            
        }
        if let distance = preferredUnits.distance {
            if let index = distanceUnits.firstIndex(of: distance) {
               self.distanceSegmentedControl.selectedSegmentIndex = index
            } else {
                self.distanceSegmentedControl.selectedSegmentIndex = 0
            }
            
        }
        if let energy = preferredUnits.energy {
            if let index = energyUnits.firstIndex(of: energy) {
               self.energySegmentedControl.selectedSegmentIndex = index
            } else {
                self.energySegmentedControl.selectedSegmentIndex = 0
            }
            
        }
        if let volume = preferredUnits.volume {
            if let index = volumeUnits.firstIndex(of: volume) {
               self.volumeSegmentedControl.selectedSegmentIndex = index
            } else {
                self.volumeSegmentedControl.selectedSegmentIndex = 0
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitOptions.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == unitOptions.count {
            return 64
        } else {
            return 44
        }
    }

    @IBAction func weightUnits_DidChange(_ sender: Any) {
        updateWeightUnits()
    }
    @IBAction func heightUnits_DidChange(_ sender: Any) {
        updateHeightUnits()
    }
    @IBAction func distanceUnits_DidChange(_ sender: Any) {
        updateDistanceUnits()
    }
    @IBAction func energyUnits_DidChange(_ sender: Any) {
        updateEnergyUnits()
    }
    @IBAction func volumeUnits_DidChange(_ sender: Any) {
        updateVolumeUnits()
    }
    
    
}

// MARK: - Model Functions
extension PreferredUnitsController {
    private func updateWeightUnits() {
        let index = weightSegmentedControl.selectedSegmentIndex
        let unit = weightUnits[index]
        self.preferredUnits.weight = unit
        API.PreferredUnits.updatePreferredUnits(withKey: "weight", value: unit)
        
    }
    private func updateHeightUnits(){
        let index = heightSegmentedControl.selectedSegmentIndex
        let unit = heightUnits[index]
        self.preferredUnits.height = unit
        API.PreferredUnits.updatePreferredUnits(withKey: "height", value: unit)
    }
    private func updateDistanceUnits(){
        let index = distanceSegmentedControl.selectedSegmentIndex
        let unit = distanceUnits[index]
        self.preferredUnits.distance = unit
        API.PreferredUnits.updatePreferredUnits(withKey: "distance", value: unit)
    }
    private func updateEnergyUnits(){
        let index = energySegmentedControl.selectedSegmentIndex
        let unit = energyUnits[index]
        self.preferredUnits.energy = unit
        API.PreferredUnits.updatePreferredUnits(withKey: "energy", value: unit)
        
    }
    private func updateVolumeUnits(){
        let index = volumeSegmentedControl.selectedSegmentIndex
        let unit = volumeUnits[index]
        self.preferredUnits.volume = unit
        API.PreferredUnits.updatePreferredUnits(withKey: "volume", value: unit)
    }
}
