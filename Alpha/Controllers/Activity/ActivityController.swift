//
//  mvvmActivityTableViewController.swift
//  Alpha
//
//  Created by Garrett Head on 12/9/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import ProgressHUD

class ActivityController: UITableViewController {


    // MARK: - HealthKit parameters
    var isHealthKitEnabled : Bool = false
    var preferredUnits : PreferredUnits?
    
    
    var activityIdentifiers : [ActivityType] = [.fitness, .nutrition, .hydration, .sleep, .mindfulness]
    var activities : [Activity] = [] { didSet { self.tableView.reloadData() } }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //authorizeHealthKit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Activity"
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshController), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        loadActivity()
        
        print("----TIME NOW and MIDNIGHT-----")
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now).timeIntervalSince1970
        print("----TIME NOW and MIDNIGHT-----")
        print("start of day: \(startOfDay) and now: \(now.timeIntervalSince1970)")
    }
    

    
    @objc private func refreshController(){
        self.activities.removeAll()
        loadActivity()
        self.refreshControl!.endRefreshing()
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return activities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities[section].archiveDataHandlers.filter({ $0.target != nil }).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if row == 0 {
            let activity = activities[section]
            let identifier = activity.progressIdentifier
            let unit = PreferredUnitFactory().createUnit(identifier, units: self.preferredUnits!)
            let viewModel = ActivityViewModel(activity: activity, withUnit: unit)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityView", for: indexPath) as! ActivityView
            cell.activityViewModel = viewModel
            return cell
        } else {
            let activity = activities[section]
            let identifier = activity.activityDataIdentifiers[row]
            let unit = PreferredUnitFactory().createUnit(identifier, units: self.preferredUnits!)
            let viewModel = ActivityTargetDataViewModel(handler: activity.getHandler(withIdentifier: identifier)!, ofUnit: unit, withColor: activity.color)
            let cell = tableView.dequeueReusableCell(withIdentifier: "TargetActivityView", for: indexPath) as! TargetActivityView
            cell.viewModel = viewModel
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 128 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        self.performSegue(withIdentifier: self.activityIdentifiers[section].rawValue, sender: activities[section])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ActivityType.hydration.rawValue {
            let destination = segue.destination as! HydrationController
            let activity = sender as! HydrationActivity
            destination.preferredUnits = self.preferredUnits
            destination.hydrationActivity =  activity
        }
        else if segue.identifier == ActivityType.nutrition.rawValue {
            let destination = segue.destination as! NutritionController
            let activity = sender as! NutritionActivity
            destination.preferredUnits = self.preferredUnits
            destination.activity =  activity
        }
    }
}


// MARK: - API
extension ActivityController {
    private func loadActivity(){
        API.PreferredUnits.observePreferredUnits(completion: { units in
            self.preferredUnits = units
            for type in self.activityIdentifiers {
                print("type: \(type)")
                API.Activity.loadTodaysActivity(type, completion: { activity in
                    self.activities.append(activity)
                })
            }
        })
    }
}


// MARK: HealthKit Extension
//extension ActivityController {
//
//    private func authorizeHealthKit() {
//        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
//            guard authorized else {
//                let baseMessage = "HealthKit Authorization Failed"
//                if let error = error {
//                    print("\(baseMessage). Reason: \(error.localizedDescription)")
//                } else {
//                    print(baseMessage)
//                }
//                return
//            }
//            self.isHealthKitEnabled = true
//        }
//    }
//
//    private func loadHealthKit(){
//        if isHealthKitEnabled {
//            // Query HK data and apply to associated Activity Types
//
//            // Sleep
//            let sleepID = sleepActivity.healthKitIdentifiers![0]
//            HealthKitAPI.getSum(forIdentifier: sleepID) { result, error in
//                guard result != nil else {
//                   if let error = error { print(error) }
//                   return
//               }
//               //self.sleepActivity.setValue(forIdentifier: sleepID, value: result)
//            }
//            // Mindfulness
//            let mindID = mindfulnessActivity.healthKitIdentifiers![0]
//            HealthKitAPI.getSum(forIdentifier: mindID) { result, error in
//                guard result != nil else {
//                   if let error = error { print(error) }
//                   return
//               }
//               //self.mindfulnessActivity.setValue(forIdentifier: mindID, value: result)
//            }
//
//             Fitness
//            for id in fitnessActivity.healthKitIdentifiers! {
//                 HealthKitAPI.getSumQuantity(forIdentifier: id) { result, error in
//                    guard let result = result else {
//                        if let error = error { print(error) }
//                        return
//                    }
//                    self.fitnessActivity.setValue(forIdentifier: id, value: result)
//                }
//            }
//        }
//    }
//}
