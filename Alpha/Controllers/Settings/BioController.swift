//
//  BioController.swift
//  Alpha
//
//  Created by Garrett Head on 8/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD


class BioController: UITableViewController {
    
    // MARK: - Bio Parameters
    private var preferredUnits : PreferredUnits = PreferredUnits()
    private var bio : Bio = Bio() {
        didSet {
            updateView()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var biologicalSexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bodyFatLabel: UILabel!
    @IBOutlet weak var bodyTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bodyTypeImageView: UIImageView!
    @IBOutlet weak var bodyTypeTextView: UITextView!
    @IBOutlet weak var activityLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityLevelDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBio()
    }
    
    private func fetchBio(){
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show("loading...", interaction: false)
        
        API.Bio.observeBio(completion: { bio in
            self.bio = bio
            API.PreferredUnits.observePreferredUnits(completion: { units in
                ProgressHUD.show(icon: .bolt)
                self.preferredUnits = units
                self.updateView()
                
            })
            API.BodyMeasurement.observeCurrentBodyMeasurement(forAttribute: "height", completion: { measurement in
                self.bio.height = measurement.value
                self.updateView()
            })
            API.BodyMeasurement.observeCurrentBodyMeasurement(forAttribute: "weight", completion: { measurement in
                self.bio.weight = measurement.value
                self.updateView()
            })
            API.BodyMeasurement.observeCurrentBodyMeasurement(forAttribute: "bodyFat", completion: { measurement in
                self.bio.bodyFat = measurement.value
                self.updateView()
            })
        })
    }
    private func updateView(){

        if let firstname = bio.firstName {
            self.firstNameTextField.text = firstname
         } else {
            self.firstNameTextField.text = ""
        }
        
        if let lastname = bio.lastName {
            self.lastNameTextField.text = lastname
        } else {
            self.lastNameTextField.text = ""
        }
        
        if let height = bio.height {
            self.heightLabel.text = "\(height) \(preferredUnits.height ?? "")"
        } else {
            self.heightLabel.text = ""
        }
        
        if let weight = bio.weight {
            self.weightLabel.text = "\(weight) \(preferredUnits.weight ?? "")"
        } else {
            self.weightLabel.text = ""
        }
        
        if let bodyFat = bio.bodyFat {
           self.bodyFatLabel.text = "\(bodyFat) %"
        } else {
            self.bodyFatLabel.text = ""
        }
        
        if let sex = bio.biologicalSex {
            if let index = biologicalSexes.firstIndex(of: sex) {
                self.biologicalSexSegmentedControl.selectedSegmentIndex = index
            }
        }
        
        if let dob = bio.dateOfBirth {
            let datetime = Date(timeIntervalSince1970: Double(dob))
            let date = datetime.getFormattedDate(format: "MMM dd, yyyy")
            self.dateOfBirthLabel.text = date
        } else {
            self.dateOfBirthLabel.text = ""
        }
        
        if let bodyType = bio.bodyType {
            if let index = bodyTypes.firstIndex(of: bodyType) {
                self.bodyTypeSegmentedControl.selectedSegmentIndex = index
                self.bodyTypeImageView.image = bodyTypeImages[index]
                self.bodyTypeTextView.text = bodyTypeDescriptions[index]
            }
        } else {
            self.bodyTypeTextView.text = "Select a body type."
        }
        
        if let activityLevel = bio.activityLevel {
            if let index = activityLevels.firstIndex(of: activityLevel) {
                self.activityLevelSegmentedControl.selectedSegmentIndex = index
                self.activityLevelDescriptionTextView.text = activityLevelDescriptions[index]
            }
        } else {
            self.activityLevelDescriptionTextView.text = "Select an activity level."
        }
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 6
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        if section == 1 && row >= 4 {
            return 154
        } else if section == 2 && row > 0 {
            return 154
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 && row == 2 {
            toggleDateOfBirthSelector()
        } else if section == 1 && row == 0 {
            performSegue(withIdentifier: "bodyMeasurement", sender: ("height",self.preferredUnits.height))
        } else if section == 1 && row == 1 {
            performSegue(withIdentifier: "bodyMeasurement", sender: ("weight",self.preferredUnits.weight))
        } else if section == 1 && row == 2 {
            performSegue(withIdentifier: "bodyMeasurement", sender: ("bodyFat","%"))
        } else {
        }
    }
    
    
    // MARK: - Actions
    @IBAction func firstName_DidEndEditing(_ sender: Any) {
        updateFirstName()
    }
    @IBAction func lastName_DidEndEditing(_ sender: Any) {
        updateLastName()
    }
    @IBAction func biologicalSex_DidChange(_ sender: Any) {
        updateBiologicalSex()
    }
    @IBAction func bodyType_DidChange(_ sender: Any) {
        updateBodyType()
    }
    @IBAction func activityLevel_DidChange(_ sender: Any) {
        updateActivityLevel()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bodyMeasurement" {
            let vc = segue.destination as! BodyMeasurementController
            let sender = sender as! (String,String)
            vc.measurementAttribute = sender.0
            vc.unit = sender.1
        }
    }
    
}


// MARK: - Pop-Up and Function Controls
extension BioController {

    
    // Toggle the height popup
    private func toggleHeightPopUp(){
        let alertController = UIAlertController(title: "Enter your height", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "in/cm"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let heightTextField = alertController.textFields![0] as UITextField
            guard let input = heightTextField.text else {
                return
            }
            if let height = Double(input) {
                self.updateHeight(withHeight: height)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Toggle the weight popup
    private func toggleWeightPopUp(){
        let alertController = UIAlertController(title: "Enter your weight", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "lbs/kg"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let weightTextField = alertController.textFields![0] as UITextField
            guard let input = weightTextField.text else {
                return
            }
            if let weight = Double(input) {
                self.updateWeight(withWeight: weight)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Toggle the body fat popup
    private func toggleBodyFatPopUp(){
        let alertController = UIAlertController(title: "Enter your body fat", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "%"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let bodyFatTextField = alertController.textFields![0] as UITextField
            guard let input = bodyFatTextField.text else {
                return
            }
            if let bodyFat = Double(input) {
                self.updateBodyFat(withBodyFat: bodyFat)
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Toggles the date of birth selector pop up.
    private func toggleDateOfBirthSelector(){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)

        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alertController.view.addSubview(myDatePicker)
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        alertController.view.addConstraint(height)
        
        let selectAction = UIAlertAction(title: "Done", style: .default, handler: { _ in
            self.updateDateOfBirth(withDate: myDatePicker.date)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

// MARK: - Model Functions
extension BioController {
    
    private func updateFirstName(){
        if let firstName = firstNameTextField.text {
            self.bio.firstName = firstName
            API.Bio.updateBio(withKey: "firstName", value: firstName)
            updateView()
        }
    }
    
    private func updateLastName(){

        if let lastName = lastNameTextField.text {
            self.bio.lastName = lastName
            API.Bio.updateBio(withKey: "lastName", value: lastName)
            updateView()
        }
    }
    
    private func updateBiologicalSex(){
        let index = biologicalSexSegmentedControl.selectedSegmentIndex
        if let biologicalSex = biologicalSexSegmentedControl.titleForSegment(at: index) {
            self.bio.biologicalSex = biologicalSex
            API.Bio.updateBio(withKey: "biologicalSex", value: biologicalSex)
            updateView()
        }
    }
    
    private func updateBodyType(){
        let index = bodyTypeSegmentedControl.selectedSegmentIndex
        if let bodyType = bodyTypeSegmentedControl.titleForSegment(at: index) {
            self.bio.bodyType = bodyType
            API.Bio.updateBio(withKey: "bodyType", value: bodyType)
            updateView()
        }
    }
    
    private func updateActivityLevel(){
        let index = activityLevelSegmentedControl.selectedSegmentIndex
        if let activityLevel = activityLevelSegmentedControl.titleForSegment(at: index) {
            activityLevelDescriptionTextView.text = activityLevelDescriptions[index]
            self.bio.activityLevel = activityLevel
            API.Bio.updateBio(withKey: "activityLevel", value: activityLevel)
            updateView()
        }
    }
    
    private func updateHeight(withHeight height: Double){
        self.bio.height = height
        API.Bio.updateBio(withKey: "height", value: height)
        updateView()
    }
    
    private func updateWeight(withWeight weight: Double){
        self.bio.weight = weight
        API.Bio.updateBio(withKey: "weight", value: weight)
        updateView()
    }
    private func updateBodyFat(withBodyFat bodyFat: Double){
        self.bio.bodyFat = bodyFat
        API.Bio.updateBio(withKey: "bodyFat", value: bodyFat)
        updateView()
    }
    private func updateDateOfBirth(withDate date: Date){
        self.bio.dateOfBirth = date.timeIntervalSince1970
        API.Bio.updateBio(withKey: "dateOfBirth", value: date.timeIntervalSince1970)
        updateView()
    }


}


