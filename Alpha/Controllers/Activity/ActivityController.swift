//
//  mvvmActivityTableViewController.swift
//  Alpha
//
//  Created by Garrett Head on 12/9/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import ProgressHUD

struct TargetedHandler {
    var handler : ActivityDataHandler
    var target : UserTarget
    var unit : Unit
}

class ActivityController: UITableViewController {


    var activityIdentifiers : [ActivityType] = [.fitness, .nutrition, .hydration, .sleep, .mindfulness]
    var activities : [Activity] = [] { didSet { manageHandlers() } }
    var isHealthKitEnabled : Bool = false
    var preferredUnits : PreferredUnits?
    var userTargets : [UserTarget] = []
    var targetedHandlers : [[TargetedHandler]] = []
    
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
        activities.removeAll()
        targetedHandlers.removeAll()
        tableView.reloadData()
        loadActivity()
        self.refreshControl!.endRefreshing()
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return targetedHandlers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetedHandlers[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let handler = targetedHandlers[section][row]
        if row == 0 {
            let activity = activities[section]
            let viewModel = ActivityViewModel(activity: activity, withUnit: handler.unit, target: handler.target)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityView", for: indexPath) as! ActivityView
            cell.activityViewModel = viewModel
            return cell
        } else {
            let activity = activities[section]
            let viewModel = ActivityTargetDataViewModel(handler: handler.handler, ofUnit: handler.unit, withColor: activity.color, target: handler.target)
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
            destination.userTargets = userTargets.filter({ $0.targetType == .hydration })
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
        ProgressHUD.show("Fetching Activity...", interaction: false)
        API.PreferredUnits.observePreferredUnits(completion: { units in
            self.preferredUnits = units
            API.UserTarget.observeTargets(completion: { targets in
                self.userTargets = targets
                for type in self.activityIdentifiers {
                    print("type: \(type)")
                    API.Activity.loadTodaysActivity(type, completion: { activity in
                        self.activities.append(activity)
                        ProgressHUD.show(icon: .bolt)
                    })
                }
            })
        })
    }
    
    private func manageHandlers() {
        targetedHandlers.removeAll()
        for activity in activities {
            let targets = userTargets.filter({ $0.targetType == activity.activityType })
            var handlers : [TargetedHandler] = []
            for target in targets {
                let handler = activity.getHandler(withIdentifier: target.id)
                let unit = PreferredUnitFactory().createUnit(target.id, units: self.preferredUnits!)
                if handler?.id == activity.progressIdentifier { handlers.insert(TargetedHandler(handler: handler!, target: target, unit: unit), at: 0) }
                else { handlers.append(TargetedHandler(handler: handler!, target: target, unit: unit)) }
            }
            targetedHandlers.append(handlers)
            tableView.reloadData()
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
