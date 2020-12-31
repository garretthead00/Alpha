//
//  DarkModeSettingsView.swift
//  Alpha
//
//  Created by Garrett Head on 9/15/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

protocol DarkModeDelegate {
    func setDarkModeSetting(isEnabled: Bool)
}

class DarkModeSettingsView: UITableViewCell {

    
    var darkModeEnabled : Bool? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - OUTLETS & ACTIONS
    @IBOutlet weak var darkModeSwitch: UISwitch!
    // MARK: - Actions
    @IBAction func DarkModeSwitch_DidChange(_ sender: Any) {
        darkModeEnabled = darkModeSwitch.isOn
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private func updateView(){
        if let enabled = darkModeEnabled {
            darkModeSwitch.isOn = enabled
        }
    }
}
