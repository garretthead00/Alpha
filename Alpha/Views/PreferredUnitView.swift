//
//  PreferredUnitView.swift
//  Alpha
//
//  Created by Garrett Head on 1/25/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

class PreferredUnitView: UITableViewCell {
    
    var name : String? { didSet { updateView() } }
    var items : [Unit]? { didSet { updateView() } }
    var preferredUnit : String? { didSet { updateView() } }
    var delegate : UnitDelegate?
    
    @IBOutlet weak var unitNameLabel: UILabel!
    @IBOutlet weak var unitOptionsSegmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.unitNameLabel.text = ""
        self.unitOptionsSegmentedControl.removeAllSegments()
    }

    private func updateView(){
        if let name = self.name {
            unitNameLabel.text = name
        }
        if let items = self.items {
            self.unitOptionsSegmentedControl.removeAllSegments()
            for (index, item) in items.enumerated() {
                self.unitOptionsSegmentedControl.insertSegment(withTitle: item.symbol, at: index, animated: true)
                if let unit = self.preferredUnit, unit == item.symbol { self.unitOptionsSegmentedControl.selectedSegmentIndex = index }
            }
        }
    }

    @IBAction func unitSelection_ValueChanged(_ sender: Any) {
        if let name = self.name,
           let items = self.items {
            let index = self.unitOptionsSegmentedControl.selectedSegmentIndex
            delegate?.updateUnits(forKey: name, withUnit: items[index])
        }
    }
}
