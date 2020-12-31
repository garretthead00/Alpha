//
//  BodyMeasurementController.swift
//  Alpha
//
//  Created by Garrett Head on 9/14/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class BodyMeasurementController: UITableViewController {

    var unit : String?
    var measurementAttribute : String? {
        didSet {
            fetchLogs()
        }
    }
    var logs : [BodyMeasurement]? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleMenu))
        logs = []
        
    }
    
    private func fetchLogs(){
        if let attribute = self.measurementAttribute {
            API.BodyMeasurement.observeBodyMeasurements(forAttribute: attribute, completion: { measurement in
                self.logs?.append(measurement)
                self.logs = self.logs?.sorted {
                    $0.date! > $1.date!
                }
            })
        }
    }
    private func updateView(){
        tableView.reloadData()
    }

   // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let logs = logs {
            return logs.count
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        if let logs = logs {
            if let date = logs[indexPath.row].date {
                let datetime = Date(timeIntervalSince1970: Double(date))
                let dateFormatted = datetime.getFormattedDate(format: "MMM dd, yyyy")
                cell.textLabel?.text = dateFormatted
            } else {
                cell.textLabel?.text = ""
            }
            if let value = logs[indexPath.row].value {
                cell.detailTextLabel?.text = "\(value) \(unit ?? "")"
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeLog(atIndexPath: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }




}

// MARK: - Alerts & Popup Menu
extension BodyMeasurementController {
    @objc private func toggleMenu(){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 112, width: 270, height: 96)
        
        
        let alertController = UIAlertController(title: "Enter your weight", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = self.unit ?? ""
            textField.keyboardType = .numberPad
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let weightTextField = alertController.textFields![0] as UITextField
            guard let input = weightTextField.text else {
                return
            }
            if let value = Double(input) {
                self.updateWeight(date: myDatePicker.date, value: value)
            }
            

        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 250)
               alertController.view.addConstraint(height)
        present(alertController, animated: true, completion:{})

    }
    
}

// MARK: - Model Functions
extension BodyMeasurementController {
    private func updateWeight(date: Date, value: Double){
        if let attribute = self.measurementAttribute {
            API.BodyMeasurement.updateBodyMeasurement(forAttribute: attribute, date: date.timeIntervalSince1970, value: value)
        }
    }
    
    private func removeLog(atIndexPath indexPath: IndexPath) {
        if let attribute = self.measurementAttribute {
            let logId = self.logs?[indexPath.row].id
            self.logs!.remove(at: indexPath.row)
            API.BodyMeasurement.removeBodyMeasurement(forAttribute: attribute, withId: logId!)
            self.updateView()
        }

    }
}
