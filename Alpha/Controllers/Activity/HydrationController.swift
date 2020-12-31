//
//  HydrationController.swift
//  Alpha
//
//  Created by Garrett Head on 12/17/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit


class HydrationController: UITableViewController {

    let OTHER : [NUTRIENT] = [.Caffeine, .Sugar, .TotalFluids]
    
    var hydrationActivity : HydrationActivity? { didSet { loadViewModels() } }
    var userTarget : UserTarget? { didSet { loadViewModels() } }
    var hydrationViewModel : HydrationViewModel?
    var hydrationLogs : [ActivityLogViewModel]? = [] { didSet { self.tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Hydration"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    @IBAction func drinkButton_Tapped(_ sender: Any) {
        presentHydrationLogMenu()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section {
            case 0: rows = 1
            case 1: rows = OTHER.count
            case 2: rows = self.hydrationLogs?.count ?? 0
            default: break
        }
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HydrationView", for: indexPath) as! HydrationView
            cell.viewModel = hydrationViewModel
            return cell
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDataView", for: indexPath) as! ActivityDataView
            let nutrient = OTHER[row].rawValue
            print("nutrient: \(nutrient)")
            cell.name = nutrient
            cell.value = hydrationActivity!.getValue(ofKey: nutrient)
            cell.icon = UIImage(named: nutrient)
            return cell
        } else {
            let log = hydrationLogs![row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityLogView", for: indexPath) as! ActivityLogView
            cell.activityLogViewModel = log
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 228}
        else if indexPath.section == 1 { return 44 }
        else { return 72 }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section > 1 ? "Logs" : ""
    }

}

extension HydrationController {
    
    private func loadViewModels(){
        if let activity = hydrationActivity, let target = userTarget {
            print("hdyrationActivity log count: \(activity.logs.count)")
            self.hydrationViewModel = HydrationViewModel(activity: activity, target: target)
            for log in activity.logs {
                let hydrationLogViewModel = ActivityLogViewModel(log: log)
                self.hydrationLogs?.append(hydrationLogViewModel)
            }
            self.tableView.reloadData()
        }
    }
    
    private func presentHydrationLogMenu(){
        let alertController = UIAlertController(title: "How much did you drink?", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = self.userTarget?.unit
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let input = textField.text else {
                return
            }
            if let value = Double(input) {
                API.Nutrition.createHydrationLog(servingSize: value)
                self.refreshLogs()
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func refreshLogs(){
        API.Activity.observeTodaysNutritionLogs(completion: {
            logs in
            self.hydrationActivity?.logs = logs.filter({ $0.food?.foodType == "drink" })
            self.hydrationLogs?.removeAll()
            self.loadViewModels()
        })
        
    }
    
}
