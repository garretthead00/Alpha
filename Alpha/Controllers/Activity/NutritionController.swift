//
//  NutritionController.swift
//  Alpha
//
//  Created by Garrett Head on 1/27/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit
import ProgressHUD

class NutritionController: UITableViewController {

    var preferredUnits : PreferredUnits?
    var activity : NutritionActivity? { didSet { loadHandlers() } }
    var userTargets : [UserTarget] = []
    
    let sectionHeaders = ["Macros", "Lipids", "Carbs", "Vitamins", "Minerals", "Ultra-Trace", "Other"]
    var groupedIdentifiers : [[ACTIVITY_DATA_IDENTIFIER]] = [
        [.EnergyConsumed, .Protein, .Fat, .Carbohydrates],  // Macros
        [.MonounsaturatedFat, .PolyunsaturatedFat, .SaturatedFat, .Cholesterol],  // Lipids
        [.Sugar, .Fiber],  // Carbs
        [.VitaminA, .VitaminB1, .VitaminB2, .VitaminB3, .VitaminB5, .VitaminB6, .VitaminB7, .VitaminC, .VitaminD, .VitaminE, .VitaminK, .Folate], // Vitamins
        [.Calcium, .Chloride, .Iron, .Magnesium, .Phosphorus, .Potassium, .Sodium, .Zinc], // Minerals
        [.Chromium, .Copper, .Iodine, .Manganese, .Molybdenum, .Selenium], // Ultra-Trace Minerals
        [.TotalFluids, .Caffeine] // Other
    ]
    
    var groupedHandlers : [[ActivityDataHandler]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Nutrition"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.sizeToFit()
    }

    private func loadHandlers(){
        if let activity = activity {
            groupedHandlers.removeAll()
            for(index, row) in groupedIdentifiers.enumerated() {
                var handlers : [ActivityDataHandler] = []
                for id in row {
                    print("index : \(index) item: \(id)")
                    if let handler = activity.getHandler(withIdentifier: id) {
                        handlers.append(handler)
                    }
                }
                groupedHandlers.append(handlers)
            }
            
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return groupedHandlers.count }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return section == 0 ? groupedHandlers[section].count  + 2 : groupedHandlers[section].count }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return section == 0 ? "" : sectionHeaders[section] }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return (indexPath.section == 0 && indexPath.row == 0) ? 96 : 44
        
        let section = indexPath.section
        let row = indexPath.row
        var height = 0.0
        if section == 0 && row == 0 { height = 96 }
        else if section == 0 && row == 1 { height = 228 }
        else { height = 44 }
        return CGFloat(height)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0{
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTargetView", for: indexPath) as! TargetedHandlerStackView
                let handler = groupedHandlers[indexPath.section][indexPath.row]
                let unit = PreferredUnitFactory().createUnit(handler.id, units: self.preferredUnits!)
                let target = userTargets.first(where: { $0.id == handler.id })
                let viewModel = TargetedHandlerStackViewModel(handler: handler, ofUnit: unit, target: target!)
                cell.viewModel = viewModel
                return cell
            } else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MacroRatioChartView", for: indexPath) as! MacroRatioChartView
                let handlers = groupedHandlers[indexPath.section]
                print("got macro handlers: \(groupedHandlers.count)")
                let proteinHandler = handlers.first(where: { $0.id == .Protein})
                let proteinTarget = userTargets.first(where: { $0.id == proteinHandler!.id })
                
                let fatHandler = handlers.first(where: { $0.id == .Fat})
                let fatTarget = userTargets.first(where: { $0.id == fatHandler!.id })
                
                let carbHandler = handlers.first(where: { $0.id == .Carbohydrates})
                let carbTarget = userTargets.first(where: { $0.id == carbHandler!.id })
                
                let vm = MacroRatioChartViewModel(protein: (proteinHandler!, proteinTarget!), fat: (fatHandler!, fatTarget!), carbs: (carbHandler!, carbTarget!))
                cell.viewModel = vm
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDataView", for: indexPath) as! ActivityDataView
                let handler = groupedHandlers[indexPath.section][indexPath.row-2]
                cell.value = handler.total
                cell.icon = handler.icon
                cell.name = handler.name
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDataView", for: indexPath) as! ActivityDataView
            let handler = groupedHandlers[indexPath.section][indexPath.row]
            cell.value = handler.total
            cell.icon = handler.icon
            cell.name = handler.name
            return cell
        }
    }
    
    private func loadActivity(){
        ProgressHUD.show("Fetching Activity...", interaction: false)
        API.PreferredUnits.observePreferredUnits(completion: { units in
            self.preferredUnits = units
            API.UserTarget.observeTargets(completion: { targets in
                self.userTargets = targets
                API.Activity.loadTodaysActivity(.nutrition, completion: { activity in
                    self.activity = activity as? NutritionActivity
                    ProgressHUD.show(icon: .bolt)
                })
            })
        })
    }
}
