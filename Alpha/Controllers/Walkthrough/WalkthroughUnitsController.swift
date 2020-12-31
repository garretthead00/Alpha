//
//  WalkthroughUnitsController.swift
//  Alpha
//
//  Created by Garrett Head on 9/23/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughUnitsController provides the user with a control to select their
// preferred units using the UISegmentedControls for each unit category.
//
// This controller has default values set to the variables in the event the user does not need
// to select anything.
//
// Options for each category are Metric vs Standard
//

import UIKit

class WalkthroughUnitsController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var weightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightSegmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var caloriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var volumeSegmentedControl: UISegmentedControl!
    
    // MARK: - Selection Variables
    private var weightUnitSelected : String?
    private var heightUnitSelected : String?
    private var distanceUnitSelected : String?
    private var caloriesUnitSelected : String?
    private var volumeUnitSelected : String?
    
    var delegate : WalkthroughDelegate?
    var preferredUnits : PreferredUnits? { didSet { updateView()} }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightSegmentedControl.selectedSegmentIndex = 0
        heightSegmentedControl.selectedSegmentIndex = 0
        distanceSegmentedControl.selectedSegmentIndex = 0
        caloriesSegmentedControl.selectedSegmentIndex = 0
        volumeSegmentedControl.selectedSegmentIndex = 0
        weightUnitSelected = weightSegmentedControl.titleForSegment(at: 0)
        heightUnitSelected = heightSegmentedControl.titleForSegment(at: 0)
        distanceUnitSelected = distanceSegmentedControl.titleForSegment(at: 0)
        caloriesUnitSelected = caloriesSegmentedControl.titleForSegment(at: 0)
        volumeUnitSelected = volumeSegmentedControl.titleForSegment(at: 0)
        updateView()
    }
    
    private func updateView() {
        guard let units = self.preferredUnits else {
            return
        }
        if let weight = self.weightUnitSelected {
            units.weight = weight
        }
        if let height = self.heightUnitSelected {
            units.height = height
        }
        if let distance = self.distanceUnitSelected {
            units.distance = distance
        }
        if let calories = self.caloriesUnitSelected {
            units.energy = calories
        }
        if let volume = self.volumeUnitSelected {
            units.volume = volume
        }
        delegate?.setUnits(units: self.preferredUnits!)
    }
    
    // MARK: - Actions
    @IBAction func weightUnitSelection_DidChange(_ sender: Any) {
        let index = weightSegmentedControl.selectedSegmentIndex
        if let unit = weightSegmentedControl.titleForSegment(at: index) {
            self.weightUnitSelected = unit
            self.preferredUnits?.weight = unit
            updateView()
        }
    }
    @IBAction func heightUnitSelection_DidChange(_ sender: Any) {
        let index = heightSegmentedControl.selectedSegmentIndex
        if let unit = heightSegmentedControl.titleForSegment(at: index) {
            self.heightUnitSelected = unit
            self.preferredUnits?.height = unit
            updateView()
        }
    }
    @IBAction func distanceUnitSelection_DidChange(_ sender: Any) {
        let index = distanceSegmentedControl.selectedSegmentIndex
        if let unit = distanceSegmentedControl.titleForSegment(at: index) {
            self.distanceUnitSelected = unit
            self.preferredUnits?.distance = unit
            updateView()
        }
    }
    @IBAction func caloriesUnitSelection_DidChange(_ sender: Any) {
        let index = caloriesSegmentedControl.selectedSegmentIndex
        if let unit = caloriesSegmentedControl.titleForSegment(at: index) {
            self.caloriesUnitSelected = unit
            self.preferredUnits?.energy = unit
            updateView()
        }
    }
    @IBAction func volumeUnitSelection_DidChange(_ sender: Any) {
        let index = volumeSegmentedControl.selectedSegmentIndex
        if let unit = volumeSegmentedControl.titleForSegment(at: index) {
            self.volumeUnitSelected = unit
            self.preferredUnits?.volume = unit
            updateView()
        }
    }
}
