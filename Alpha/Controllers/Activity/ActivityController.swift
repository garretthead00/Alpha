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

    
    // MARK: - ACTIVITIES
    var fitnessActivity : FitnessActivity = FitnessActivity()
    var nutritionActivity : NutritionActivity = NutritionActivity()
    var hydrationActivity : HydrationActivity = HydrationActivity()
    var sleepActivity : SleepActivity = SleepActivity()
    var mindfulnessActivity : MindfulnessActivity = MindfulnessActivity()
    var activityViewModels : [ActivityViewModel] = []
    var fitnessActivityVM : ActivityViewModel?
    var nutritionActivityVM : ActivityViewModel?
    var hydrationActivityVM : ActivityViewModel?
    var sleepActivityVM : ActivityViewModel?
    var mindfulnessActivityVM : ActivityViewModel?
    
    // MARK: - TARGETS
    var userTargets : [UserTarget] = []
    var fitnessTargetViewModels : [TargetActivityViewModel] = []
    var nutritionTargetViewModels : [TargetActivityViewModel] = []
    
    // MARK: - HealthKit parameters
    var isHealthKitEnabled : Bool = false
    
    var activities : [String] = ["fitness", "nutrition", "hydration", "sleep", "mindfulness"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        authorizeHealthKit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation config
        navigationItem.title = "Activity"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // ProgressHUB config
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        
        // Refresh Control config
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshController), for: UIControl.Event.valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        // Load Data
        loadData()
    }
    
    private func loadData(){
        ProgressHUD.show("Activity...", interaction: false)
        API.UserTarget.observeTargets(completion: { [self] targets in
            ProgressHUD.show(icon: .bolt)
            self.userTargets = targets
            API.Archive.loadTodaysArchiveData(forIdentifiers: self.fitnessActivity.activityDataIdentifiers, completion: {
                handlers in
                self.fitnessActivity.archiveDataHandlers = handlers
                self.updateController()
            })
            API.Archive.loadTodaysArchiveData(forIdentifiers: self.nutritionActivity.activityDataIdentifiers, completion: {
                handlers in
                self.nutritionActivity.archiveDataHandlers = handlers
                self.updateController()
            })
            API.Archive.loadTodaysArchiveData(forIdentifiers: self.hydrationActivity.activityDataIdentifiers, completion: {
                handlers in
                self.hydrationActivity.archiveDataHandlers = handlers
                self.updateController()
            })
            //self.loadHealthKit()
            //self.updateController()

        })
        
    }
    
    @objc private func refreshController(){
        self.userTargets.removeAll()
        loadData()
        self.refreshControl!.endRefreshing()
    }
    
    private func updateController(){

        // HealthKit enabled
        self.fitnessActivity.healthKitEnabled = isHealthKitEnabled
        self.nutritionActivity.healthKitEnabled = isHealthKitEnabled
        self.hydrationActivity.healthKitEnabled = isHealthKitEnabled
        self.sleepActivity.healthKitEnabled = isHealthKitEnabled
        self.mindfulnessActivity.healthKitEnabled = isHealthKitEnabled
        
        self.activityViewModels.removeAll()
        self.fitnessTargetViewModels.removeAll()
        self.nutritionTargetViewModels.removeAll()
        for target in userTargets.filter({ $0.targetType == .fitness && $0.id != .EnergyBurned}) {
            let targetVM = TargetActivityViewModel(target: target, progress: fitnessActivity.getValue(withIdentifier: target.id), color: fitnessActivity.color, isPercent: false)
            fitnessTargetViewModels.append(targetVM)
        }
        for target in userTargets.filter({ $0.targetType == .nutrition && $0.id != .EnergyConsumed}) {
            nutritionTargetViewModels.append(TargetActivityViewModel(target: target, progress: nutritionActivity.getValue(withIdentifier: target.id), color: nutritionActivity.color, isPercent: true))
        }
        if let fitnessTarget = self.userTargets.filter({ $0.id == .EnergyBurned}).first {
            self.fitnessActivityVM = ActivityViewModel(activity: self.fitnessActivity, target: fitnessTarget)
            self.activityViewModels.append(self.fitnessActivityVM!)
        }
        if let nutritionTarget = self.userTargets.filter({ $0.id == .EnergyConsumed}).first {
            self.nutritionActivityVM = ActivityViewModel(activity: self.nutritionActivity, target: nutritionTarget)
            self.activityViewModels.append(self.nutritionActivityVM!)
        }
        if let hydrationTarget = self.userTargets.filter({ $0.id == .Water}).first {
            self.hydrationActivityVM = ActivityViewModel(activity: self.hydrationActivity, target: hydrationTarget)
            self.activityViewModels.append(self.hydrationActivityVM!)
        }
        if let sleepTarget = self.userTargets.filter({ $0.id == .SleepMinutes}).first {
            self.sleepActivityVM = ActivityViewModel(activity: self.sleepActivity, target: sleepTarget)
            self.activityViewModels.append(self.sleepActivityVM!)
        }
        if let mindfulnessTarget = self.userTargets.filter({ $0.id == .MindfulMinutes}).first {
            self.mindfulnessActivityVM = ActivityViewModel(activity: self.mindfulnessActivity, target: mindfulnessTarget)
            self.activityViewModels.append(self.mindfulnessActivityVM!)
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return activityViewModels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if userTargets.count > 0 {
            switch section {
                case 0: count = fitnessTargetViewModels.count + 1
                case 1: count = nutritionTargetViewModels.count + 1
                default : count = 1
            }
        }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityView", for: indexPath) as! ActivityView
            cell.activityViewModel = activityViewModels[indexPath.section]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TargetActivityView", for: indexPath) as! TargetActivityView
            switch section {
                case 0: cell.viewModel = fitnessTargetViewModels[row - 1]
                case 1: cell.viewModel = nutritionTargetViewModels[row - 1]
                default : break
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 128 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section > 0 {
            self.performSegue(withIdentifier: self.activities[section], sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hydration" {
            let destination = segue.destination as! HydrationController
            destination.hydrationActivity =  self.hydrationActivity
            destination.userTarget = self.userTargets.filter({ $0.id == .Water}).first
        }
    }
}


// MARK: HealthKit Extension
extension ActivityController {
    
    private func authorizeHealthKit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            self.isHealthKitEnabled = true
        }
    }
    
    private func loadHealthKit(){
        if isHealthKitEnabled {
            // Query HK data and apply to associated Activity Types
            
            // Sleep
            let sleepID = sleepActivity.healthKitIdentifiers![0]
            HealthKitAPI.getSum(forIdentifier: sleepID) { result, error in
                guard result != nil else {
                   if let error = error { print(error) }
                   return
               }
               //self.sleepActivity.setValue(forIdentifier: sleepID, value: result)
            }
            // Mindfulness
            let mindID = mindfulnessActivity.healthKitIdentifiers![0]
            HealthKitAPI.getSum(forIdentifier: mindID) { result, error in
                guard result != nil else {
                   if let error = error { print(error) }
                   return
               }
               //self.mindfulnessActivity.setValue(forIdentifier: mindID, value: result)
            }
            
            // Fitness
//            for id in fitnessActivity.healthKitIdentifiers! {
//                 HealthKitAPI.getSumQuantity(forIdentifier: id) { result, error in
//                    guard let result = result else {
//                        if let error = error { print(error) }
//                        return
//                    }
//                    self.fitnessActivity.setValue(forIdentifier: id, value: result)
//                }
//            }
            updateController()
        }
    }
}
