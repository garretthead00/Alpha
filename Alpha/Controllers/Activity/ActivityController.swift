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
    
    
    var activityIdentifiers : [ActivityType] = [.fitness, .nutrition, .hydration, .sleep, .mindfulness]
    var activities : [Activity] = [] { didSet { self.tableView.reloadData() } }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //authorizeHealthKit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation config
        navigationItem.title = "Activity"
        // navigationController?.navigationBar.prefersLargeTitles = true
        
        // ProgressHUB config
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        
        // Refresh Control config
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshController), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        loadActivity()
    }
    
    private func loadActivity(){
        print("-----LOAD ACTIVITY-----")
        for type in activityIdentifiers {
            print("type: \(type)")
            API.Activity.loadTodaysActivity(type, completion: { activity in
                print("---Activity: \(activity.name) ---progress: \(activity.progress ?? 0.0)")
                self.activities.append(activity)
            })
        }
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
        return activities[section].activityDataIdentifiers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if row == 0 {
            let viewModel = ActivityViewModel(activity: activities[section])
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityView", for: indexPath) as! ActivityView
            cell.activityViewModel = viewModel
            return cell
        } else {
            let activity = activities[section]
            let identifier = activity.activityDataIdentifiers[row]
            let viewModel = TargetActivityViewModel(handler: activity.getHandler(withIdentifier: identifier)!, color: activity.color, isPercent: false)
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
        if section > 0 {
            self.performSegue(withIdentifier: self.activityIdentifiers[section].rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hydration" {
            //let destination = segue.destination as! HydrationController
            //destination.hydrationActivity =  self.hydrationActivity
        }
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
