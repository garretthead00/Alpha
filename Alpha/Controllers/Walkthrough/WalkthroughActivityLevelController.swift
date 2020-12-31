//
//  WalkthroughActivityLevelController.swift
//  Alpha
//
//  Created by Garrett Head on 9/21/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughActivityLevelController provides the user with a control to select their
// regular activity level using the UISegmentedControl.
//
// This controller displays the associated item and description of the activity level selected
// in the segmented control.
//

import UIKit

class WalkthroughActivityLevelController: UIViewController {

    @IBOutlet weak var activityLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityLevelTextView: UITextView!
    @IBOutlet weak var activityLevelImageView: UIImageView!
    
    var delegate : WalkthroughDelegate?
    var bio : Bio? { didSet { updateView() } }
    var activityLevel : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLevel = activityLevels[0]
        updateView()
    }

    private func updateView(){
        if let activityLevel = activityLevel {
            guard let index = activityLevels.firstIndex(of: activityLevel) else {
                activityLevelSegmentedControl.selectedSegmentIndex = 0
                activityLevelTextView.text = activityLevelDescriptions[0]
                activityLevelImageView.image = activityLevelImages[0]
                return
            }
            activityLevelSegmentedControl.selectedSegmentIndex = index
            activityLevelTextView.text = activityLevelDescriptions[index]
            activityLevelImageView.image = activityLevelImages[index]
        } else {
            activityLevelSegmentedControl.selectedSegmentIndex = 0
            activityLevelTextView.text = activityLevelDescriptions[0]
            activityLevelImageView.image = activityLevelImages[0]
        }
    }

    // MARK: Actions
    @IBAction func updateActivityLevel(_ sender: Any) {
        updateActivityLevel()
    }
    
    private func updateActivityLevel(){
        let index = activityLevelSegmentedControl.selectedSegmentIndex
        if let activityLevel = activityLevelSegmentedControl.titleForSegment(at: index) {
            activityLevelTextView.text = activityLevelDescriptions[index]
            activityLevelImageView.image = activityLevelImages[index]
            self.activityLevel = activityLevel
            delegate?.setActivityLevel(activityLevel: activityLevel)
        }
    }
}


