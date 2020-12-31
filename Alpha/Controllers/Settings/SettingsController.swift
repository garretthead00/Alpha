//
//  SettingsController.swift
//  Alpha
//
//  Created by Garrett Head on 8/19/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth

enum DarkModeSetting : String {
    case OFF = "Off"
    case ON = "On"
    case SYSTEM = "System"
}

class SettingsController: UITableViewController {

    let sectionHeaders = ["","Appearance", ""]
    
    // MARK: - Appearance Parameters & Outlets
    var darkModeSetting : String?
    @IBOutlet weak var darkModeLabel: UILabel!
    var colorThemeSetting : UIColor?
    @IBOutlet weak var colorThemeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    
    private func updateView(){
        let defaults = UserDefaults.standard
        if let darkMode = defaults.string(forKey: "darkMode") {
            self.darkModeSetting = darkMode
            self.darkModeLabel.text = darkMode
        }
        
        if let teamColor = defaults.colorForKey(key: "teamColor") {
            self.colorThemeSetting = teamColor
            self.colorThemeLabel.text = teamColor.name ?? ""
            self.colorThemeLabel.textColor = teamColor
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let section = indexPath.section
        if section == 1 && row == 0 {
            openDarkModeSelectionMenu()
        } else if section == 1 && row == 2 {
            let sb = UIStoryboard(name: "Walkthrough", bundle: nil)
            if let pageVC = sb.instantiateViewController(withIdentifier: "WalkthroughPageController") as? WalkthroughController {
                self.present(pageVC, animated: true, completion: nil)
            }
        } else if indexPath.section == tableView.numberOfSections - 1 {
            logoutUser()
        }
    }


    private func logoutUser(){
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let error {
            print(error)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamColor" {
            let vc = segue.destination as! TeamColorController
            vc.delegate = self
        }
    }

    
}


// MARK: - Appearance
extension SettingsController {
    
    // Dark Mode Selection Menu
    func openDarkModeSelectionMenu() {
        let selectedValue = self.darkModeSetting
        let action = UIAlertController.actionSheetWithItems(items: [(DarkModeSetting.OFF.rawValue,DarkModeSetting.OFF.rawValue),
            (DarkModeSetting.ON.rawValue,DarkModeSetting.ON.rawValue),
            (DarkModeSetting.SYSTEM.rawValue,DarkModeSetting.SYSTEM.rawValue)], currentSelection: selectedValue, action: { (value)  in
            self.darkModeSetting = value
            self.setDarkModeSettings()
         })
        action.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(action, animated: true, completion: nil)
    }
    
    func setDarkModeSettings(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
          fatalError("could not get scene delegate ")
        }
        
        // Set the user defaults to save the settings for later.
        let defaults = UserDefaults.standard
        defaults.set(self.darkModeSetting, forKey: "darkMode")
        
        // Set the application interface style.
        switch self.darkModeSetting {
            case DarkModeSetting.OFF.rawValue : window.overrideUserInterfaceStyle = .light
            case DarkModeSetting.ON.rawValue : window.overrideUserInterfaceStyle = .dark
            default :
                window.overrideUserInterfaceStyle = .unspecified
        }
        self.updateView()
        
    }
    
}

extension SettingsController : TeamColorDelegate {
    func setTeamColor(color: UIColor) {
        self.colorThemeSetting = color
        let defaults = UserDefaults.standard
        defaults.setColor(color: color, forKey: "teamColor")
        self.updateView()
    }
    
    
}








