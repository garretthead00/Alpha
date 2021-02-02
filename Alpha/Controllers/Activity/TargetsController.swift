//
//  ActivityHandlerController.swift
//  Alpha
//
//  Created by Garrett Head on 1/22/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit
import ProgressHUD

class TargetsController: UITableViewController {

    var preferredUnits : PreferredUnits?
    var targetHandlers : [TargetHandler] = [] { didSet { manageData() } }
    var groupedHandlers = [[ActivityTargetHandlerViewModel]]()
    var bodyGoal : String?
    
    let sectionTitles = ["Body", "Fitness", "Nutrition", "Hydration", "Sleep", "Mindfulness"]
    let primaryTargets : [ACTIVITY_DATA_IDENTIFIER] = [.EnergyBurned, .EnergyConsumed, .Water, .SleepMinutes, .MindfulMinutes]
    var targetViewModels : [ActivityTargetHandlerViewModel] = []
    let unitFactory = PreferredUnitFactory()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Targets"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.allowsSelectionDuringEditing = true
        
        // ProgressHUB config
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        
        loadTargets()
    }

    // MARK: IBActions and Outlets
    @IBAction func editButton_Tapped(_ sender: Any) { editTargets() }
    
    // MARK: - Table view methods
    override func numberOfSections(in tableView: UITableView) -> Int { return groupedHandlers.count + 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return section == 0 ? 1 : groupedHandlers[section-1].count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return sectionTitles[section] }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool { return false }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return .none }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyGoalTargetView", for: indexPath) as! BodyGoalView
            cell.delegate = self
            cell.bodyGoal = self.bodyGoal
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HandlerView", for: indexPath) as! ActivityHandlerView
            cell.viewModel = groupedHandlers[section-1][row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing, let view = tableView.cellForRow(at: indexPath) {
            let section = indexPath.section
            let row = indexPath.row
            let viewIdentifier = view.reuseIdentifier
            switch viewIdentifier {
                case "HandlerView" :
                    print("handlerview")
                    let target = groupedHandlers[section-1][row]
                    if target.targetType == .nutrition {
                        setMacroTarget()
                    } else {
                        promptTargetMenu(forViewModel: target)
                    }
                    
                case "BodyGoalTargetView": break
                default: break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "macroMenu" {
            let destination = segue.destination as! MacroTargetMenuController
            destination.delegate = self
            destination.viewModels = targetViewModels.filter({ $0.targetType == .nutrition })
        }
    }
}


// MARK: Target methods
extension TargetsController {
    
    private func editTargets(){
        if isEditing {
            saveTargets()
        }
        isEditing = !isEditing
        navigationItem.hidesBackButton = isEditing
        navigationItem.rightBarButtonItem?.title = isEditing ? "Save" : "Edit"
        tableView.reloadData()
    }
    
    private func promptTargetMenu(forViewModel viewModel: ActivityTargetHandlerViewModel) {
        // get userTarget with id from list of targets
        let alertController = UIAlertController(title: "Enter your target", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "\(viewModel.unit.symbol)"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let input = textField.text else {
                return
            }
            if let value = Double(input) {
                print("saving target for \(viewModel.identifier) with value of \(value) \(viewModel.unit)")
                self.setTarget(forIdentifier: viewModel.identifier, withValue: value, ofUnit: viewModel.unit)
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setTarget(forIdentifier identifier: ACTIVITY_DATA_IDENTIFIER, withValue value: Double, ofUnit unit: Unit) {
        if let index = self.targetHandlers.firstIndex(where: { $0.id == identifier }) {
            let convertedValue = UnitConverter().convert(value: value, toUnit: self.targetHandlers[index].unit, fromUnit: unit)
            self.targetHandlers[index].value = convertedValue
            manageData()
        }
    }
    
    private func setMacroTarget() { self.performSegue(withIdentifier: "macroMenu", sender: nil) }
}


// MARK: - DATA HANDLING; API service calls
extension TargetsController {
    
    private func loadTargets(){
        ProgressHUD.show("Fetching Targets...", interaction: false)
        API.Bio.fetchBodyGoal(completion: { goal in
            self.bodyGoal = goal
            API.PreferredUnits.observePreferredUnits(completion: { units in
                self.preferredUnits = units
                API.UserTarget.fetchTargetHandlers(completion: { handlers in
                    self.targetHandlers = handlers
                    ProgressHUD.show(icon: .bolt)
                })
            })
        })
    }
    
    private func saveTargets(){
        API.Bio.updateBio(withKey: "bodyGoal", value: self.bodyGoal!)
        API.UserTarget.updateTargets(targets: self.targetHandlers)
    }
    
    private func manageData(){
        groupedHandlers.removeAll()
        targetViewModels.removeAll()
        for handler in targetHandlers { targetViewModels.append(ActivityTargetHandlerViewModel(handler: handler, unit: unitFactory.createUnit(handler.id, units: preferredUnits!))) }
        groupedHandlers.append(targetViewModels.filter({ $0.targetType == .fitness }))
        groupedHandlers.append(targetViewModels.filter({ $0.targetType == .nutrition }))
        groupedHandlers.append(targetViewModels.filter({ $0.targetType == .hydration }))
        groupedHandlers.append(targetViewModels.filter({ $0.targetType == .sleep }))
        groupedHandlers.append(targetViewModels.filter({ $0.targetType == .mindfulness }))
        tableView.reloadData()
    }
    
}

// MARK: Protocol TargetDelegate
extension TargetsController : TargetDelegate {
    func updateBodyGoalTarget(value: String) { self.bodyGoal = value }
    
    func updateMacros(viewModels: [ActivityTargetHandlerViewModel]){
        for vm in viewModels { setTarget(forIdentifier: vm.identifier, withValue: vm.value, ofUnit: vm.unit) }
        manageData()
    }
}


