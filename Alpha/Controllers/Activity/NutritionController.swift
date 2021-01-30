//
//  NutritionController.swift
//  Alpha
//
//  Created by Garrett Head on 1/27/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

class NutritionController: UITableViewController {

    var preferredUnits : PreferredUnits?
    var activity : NutritionActivity? { didSet { loadHandlers() } }
    var handlers : [ActivityDataHandler] = []
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Hydration"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }

    private func loadHandlers(){
        if let activity = activity {
            handlers = activity.archiveDataHandlers
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return handlers.count }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDataView", for: indexPath) as! ActivityDataView
        let handler = handlers[indexPath.row]
        print("Nutrition Handler: -----\(handler.name) \(handler.total) \(handler.unit)")
        cell.value = handler.total
        cell.icon = handler.icon
        cell.name = handler.name
        return cell
    }
    

  

}
