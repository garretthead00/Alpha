//
//  WalkthroughBioController.swift
//  Alpha
//
//  Created by Garrett Head on 9/19/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughBioController provides a scene for the user to input general bio data.
// This controller manages the UI inputs and the data model for the bio.
//
// The general bio data collected, if provided, is the user's
//      First Name
//      Last Name
//      Date of Birth
//      Biological Sex
//

import UIKit

class WalkthroughBioController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var biologicalSexSegmentedControl: UISegmentedControl!
    
    // MARK: - Bio Variables
    private var firstName : String?
    private var lastName : String?
    private var dateOfBirth : Date?
    private var biologicalSex : String?
    var delegate : WalkthroughDelegate?
    var bio : Bio? { didSet { updateView() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName = ""
        firstNameTextField.text = ""
        lastName = ""
        lastNameTextField.text = ""
        dateOfBirth = dobDatePicker.date
        biologicalSexSegmentedControl.selectedSegmentIndex = 0
        biologicalSex = biologicalSexSegmentedControl.titleForSegment(at: 0)
    }
    
    private func updateView(){
        if let bio = self.bio {
            if let firstName = self.firstName {
                bio.firstName = firstName
                self.firstNameTextField.text = firstName
            }
            if let lastName = self.lastName {
                bio.lastName = lastName
                self.lastNameTextField.text = lastName
            }
            if let dateOfBirth = self.dateOfBirth {
                bio.dateOfBirth = dateOfBirth.timeIntervalSince1970
                self.dobDatePicker.date = dateOfBirth
            }
            if let sex = self.biologicalSex {
                bio.biologicalSex = sex
                if let index = biologicalSexes.firstIndex(of: sex) {
                    self.biologicalSexSegmentedControl.selectedSegmentIndex = index
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func firstNameTextField_DidEndEditing(_ sender: Any) {
        if let firstName = firstNameTextField.text {
            self.firstName = firstName
            delegate?.setFirstName(firstName: firstName)
            updateView()
        }
    }
    
    @IBAction func lastNameTextField_DidEndEditing(_ sender: Any) {
        if let lastName = lastNameTextField.text {
            self.lastName = lastName
            delegate?.setLastName(lastName: lastName)
            updateView()
        }
    }
    
    @IBAction func biologicalSex_DidChange(_ sender: Any) {
        let index = biologicalSexSegmentedControl.selectedSegmentIndex
        if let biologicalSex = biologicalSexSegmentedControl.titleForSegment(at: index) {
            self.biologicalSex = biologicalSex
            delegate?.setBiologicalSex(sex: biologicalSex)
            updateView()
        }
    }
    
    @IBAction func dateOfBirth_DidChange(_ sender: Any) {
        let date = dobDatePicker.date
        self.dateOfBirth = dobDatePicker.date
        delegate?.setDoB(dob: date)
        updateView()
    }
}

