//
//  BodyGoalView.swift
//  Alpha
//
//  Created by Garrett Head on 10/31/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit


class BodyGoalView: UITableViewCell {

    @IBOutlet weak var bodyGoalSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let segments : [String] = ["Lose Fat", "Maintain", "Gain Muscle"]
    let descriptions : [String] = ["Your goal determines the amount of calories you need each day. Depending on your activity level, body type, and your goals, the daily caloric intake will generate either a surplus or deficiency of calories to consume eachday."]
    var delegate : TargetDelegate?
    var bodyGoal : String? {
        didSet{
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for index in 0..<segments.count {
            bodyGoalSegmentedControl.setTitle(segments[index], forSegmentAt: index)
        }
        bodyGoalSegmentedControl.selectedSegmentIndex = 1
        updateView()
    }
    
    private func updateView(){
        
        bodyGoalSegmentedControl.isEnabled = isEditing
        
        if let bodyGoal = self.bodyGoal {
            if let index = segments.firstIndex(of: bodyGoal) {
                bodyGoalSegmentedControl.selectedSegmentIndex = index
            }
        }
        descriptionLabel.text = descriptions[0]
    }

    @IBAction func BodyGoal_DidChange(_ sender: Any) {
        let index = bodyGoalSegmentedControl.selectedSegmentIndex
        if let bodyGoal = bodyGoalSegmentedControl.titleForSegment(at: index) {
            self.bodyGoal = bodyGoal
            delegate?.updateBodyGoalTarget(value: bodyGoal)
            self.updateView()
        }
        
        
    }
}
