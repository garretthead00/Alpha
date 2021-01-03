//
//  TargetsController.swift
//  Alpha
//
//  Created by Garrett Head on 10/28/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import ProgressHUD



protocol UserTargetDelegate {
    func updateBodyGoalTarget(value: String)
    func setTarget(target: UserTarget)
    func updateMacros(protein : Double, fat: Double, carbs: Double, sum: Double)
}

class TargetsController: UITableViewController {

    // MARK: - Target Attributes
    let sections = ["Body", "Fitness", "Nutrition", "Hydration", "Sleep", "Mindfulness"]
    
    var bodyGoal : String? { didSet { updateController() } }
    var userTargets : [UserTarget] = [] { didSet { updateController() } }
    var fitnessTargets : [UserTarget] = []
    var nutritionTargets : [UserTarget] = []
    var hydrationTargets : [UserTarget] = []
    var sleepTargets : [UserTarget] = []
    var mindfulnessTargets : [UserTarget] = []
    
    
    // MARK: - Target Parameters
    var macroSum : Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation config
        navigationItem.title = "Targets"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        // ProgressHUB config
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        
        
        // fetch UserTargets from database.
        fetchUserTargets()
    }
    
    private func updateController(){
        navigationItem.hidesBackButton = isEditing
        navigationItem.rightBarButtonItem?.title = isEditing ? "Save" : "Edit"
        tableView.reloadData()
    }
    
    @IBAction func editButton_Tapped(_ sender: Any) {
        if (macroSum == 0 || macroSum == 100) {
            if isEditing {
                saveTargets()
            }
            isEditing = !isEditing
        }
        updateController()
    }
    
    private func fetchUserTargets() {
        ProgressHUD.show("targets...", interaction: false)
        API.Bio.fetchBodyGoal(completion: { goal in
            self.bodyGoal = goal
            API.UserTarget.observeTargets(completion: { targets in
                ProgressHUD.show(icon: .bolt)
                self.userTargets = targets
                self.manageTargets()
                
            })
        })
    }
    
    private func manageTargets(){
        fitnessTargets.removeAll()
        nutritionTargets.removeAll()
        hydrationTargets.removeAll()
        sleepTargets.removeAll()
        mindfulnessTargets.removeAll()
        fitnessTargets = userTargets.filter({ $0.targetType == .fitness })
        nutritionTargets = userTargets.filter({ $0.targetType == .nutrition })
        hydrationTargets = userTargets.filter({ $0.targetType == .hydration })
        sleepTargets = userTargets.filter({ $0.targetType == .sleep })
        mindfulnessTargets = userTargets.filter({ $0.targetType == .mindfulness })
        updateController()
    }
    
    private func saveTargets(){
        ProgressHUD.show("saving...", interaction: false)
        API.UserTarget.updateTargets(targets: userTargets)
        ProgressHUD.show(icon: .bolt)
        manageTargets()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = 1
        } else if section == 1 {
            rowCount = fitnessTargets.count
        } else if section == 2 {
            rowCount = nutritionTargets.count > 0 ? 2 : 0
        } else if section == 3 {
            rowCount = hydrationTargets.count
        } else if section == 4 {
            rowCount = sleepTargets.count
        } else if section == 5 {
            rowCount = mindfulnessTargets.count
        } else {
            rowCount = 0
        }
        return rowCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyGoalTargetView", for: indexPath) as! BodyGoalView
            cell.delegate = self
            cell.bodyGoal = self.bodyGoal
            return cell
        } else {
            if section == 2 && row > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MacrosTargetView", for: indexPath) as! MacrosTargetView
                cell.delegate = self
                cell.energyConsumed = nutritionTargets.first(where: { $0.id == .EnergyConsumed })!.value
                cell.protein = nutritionTargets.first(where: { $0.id == .Protein })!.value
                cell.fat = nutritionTargets.first(where: { $0.id == .Fat })!.value
                cell.carbohydrate = nutritionTargets.first(where: { $0.id == .Carbohydrates })!.value
                return cell
            } else {
                var target : UserTarget?
                switch section {
                    case 1: target = fitnessTargets[row]
                case 2: target = nutritionTargets.filter({ $0.id == .EnergyConsumed }).first
                    case 3: target = hydrationTargets[row]
                    case 4: target = sleepTargets[row]
                    case 5: target = mindfulnessTargets[row]
                    default: print("bad target")
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "TargetView", for: indexPath) as! TargetView
                cell.delegate = self
                cell.userTarget = target
                return cell
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            return 164
        } else if (section == 2 && row > 0) {
            return 142
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing {
            let section = indexPath.section
            let row = indexPath.row
            if !((section == 0 || (section == 2 && row > 0))) {
                switch section {
                    case 1: setTarget(target: fitnessTargets[row])
                    case 2: setTarget(target: nutritionTargets[row])
                    case 3: setTarget(target: hydrationTargets[row])
                    case 4: setTarget(target: sleepTargets[row])
                    case 5: setTarget(target: mindfulnessTargets[row])
                    default: print("bad target")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension TargetsController : UserTargetDelegate {
    func updateMacros(protein: Double, fat: Double, carbs: Double, sum: Double) {
        setTarget(withIdentifier: .Protein, value: protein)
        setTarget(withIdentifier: .Fat, value: fat)
        setTarget(withIdentifier: .Carbohydrates, value: carbs)
        macroSum = sum
        print("update macros: sum = \(macroSum)")
    }
    
    func setTarget(withIdentifier identifier: ACTIVITY_DATA_IDENTIFIER, value: Double){
        let index = userTargets.firstIndex(where: { $0.id == identifier})
        userTargets[index!].value = value
        manageTargets()
    }
    
    func setTarget(target: UserTarget) {
        
        // get userTarget with id from list of targets
        let alertController = UIAlertController(title: "Enter your target", message: "\(target.id)", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "--"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let input = textField.text else {
                return
            }
            if let value = Double(input) {
                target.value = value
                //API.UserTarget.updateUserTarget(target: target.id, value: value)
                //self.manageTargets()
                self.updateController()
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateBodyGoalTarget(value: String) {
        self.bodyGoal = value
    }
}

