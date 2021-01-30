//
//  HydrationController.swift
//  Alpha
//
//  Created by Garrett Head on 12/17/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

protocol HydrationDelegate {
    func createLog(withValue value: Double, ofUnit unit: Unit)
}

class HydrationController: UITableViewController {

    var preferredUnits : PreferredUnits?
    var hydrationActivity : HydrationActivity? { didSet { loadHydrationLogs() } }
    var hydrationViewModel : HydrationViewModel?
    var hydrationTargetViewModel : HydrationTargetViewModel?
    var hydrationLogs : [ActivityLogViewModel]? = []
    var logs : [NutritionLog]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadHydrationLogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Hydration"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 3 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        switch section {
            case 0: rows = 1
            case 1: rows = 1
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HydrationTargetView", for: indexPath) as! HydrationTargetView
            cell.hydrationTargetViewModel = hydrationTargetViewModel
            return cell
        } else {
            let log = hydrationLogs![row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityLogView", for: indexPath) as! ActivityLogView
            cell.activityLogViewModel = log
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 228 }
        if indexPath.section == 1 { return  96 }
        else { return 44 }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section > 1 ? "Logs" : ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateHydrationLog" {
            let destination = segue.destination as! CreateHydrationLogController
            destination.delegate = self
        }
    }

}

extension HydrationController {
    
    private func loadHydrationLogs(){
        API.Activity.observeTodaysNutritionLogs(completion: {
            logs in
            self.logs = logs
            self.loadViewModels()
        })
    }
    
    private func reloadActivity(){
        self.logs?.removeAll()
        
        API.Activity.loadTodaysActivity(.hydration, completion: { activity in
            self.hydrationActivity = activity as? HydrationActivity
            API.Activity.observeTodaysNutritionLogs(completion: {
                logs in
                self.logs = logs
                self.loadViewModels()
            })
        })
    }
    
    private func loadViewModels(){
        print("loadViewModels")
        self.hydrationLogs?.removeAll()
        if let activity = hydrationActivity,
           let preferredUnits = preferredUnits {
            let handler = activity.getHandler(withIdentifier: activity.progressIdentifier)
            let unit = PreferredUnitFactory().createUnit(activity.progressIdentifier, units: preferredUnits)
            self.hydrationViewModel = HydrationViewModel(handler: handler!, ofUnit: unit)
            self.hydrationTargetViewModel = HydrationTargetViewModel(handler: handler!, ofUnit: unit)

            if var logs = logs {
                logs.sort(by: { $0.timestamp! > $1.timestamp! })
                for log in logs {
                    let hydrationLogViewModel = ActivityLogViewModel(log: log, target: handler!.target!)
                    self.hydrationLogs?.append(hydrationLogViewModel)
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
    }
}


extension HydrationController : HydrationDelegate {
    func createLog(withValue value: Double, ofUnit unit: Unit) {
        let water = Food(id: "xxALPHAXxx_Water",
                        name: ACTIVITY_DATA_IDENTIFIER.Water.rawValue,
                        foodType: "drink",
                        category: ACTIVITY_DATA_IDENTIFIER.Water.rawValue,
                        servingSize: value,
                        unit: unit.symbol,
                        nutrition: [NutritionHandler(id: ACTIVITY_DATA_IDENTIFIER.Water.rawValue, name: "Water", value: value, unit: unit.symbol)])
        
        API.Activity.createLog(withFood: water, completion: { ref in
            let handler = ArchiveDataHandlerFactory().makeDataHandler(.Water, data: [Date():value])
            let unit = PreferredUnitFactory().createUnit(handler.id, units: self.preferredUnits!)
            API.Archive.archiveData(fromHandler: handler, ofUnit: unit, withLogId: ref)
            self.reloadActivity()
        })
        
    }
    
    
}
