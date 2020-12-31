//
//  WalkthroughBodyTypeController.swift
//  Alpha
//
//  Created by Garrett Head on 9/20/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughBodyTypeController provides the user with a control to select their
// body type using the UISegmentedControl.
//
// This controller displays the associated item and description of the body type selected
// in the segmented control.
//

import UIKit

class WalkthroughBodyTypeController: UIViewController {

    @IBOutlet weak var bodyTypeImageView: UIImageView!
    @IBOutlet weak var bodyTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bodyTypeTextView: UITextView!
    
    var delegate : WalkthroughDelegate?
    var bio : Bio? { didSet { updateView() } }
    private var bodyType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyType = bodyTypes[0]
        bodyTypeImageView.image = bodyTypeImages[0]
        updateView()
    }
    
    private func updateView(){
        if let bodyType = bodyType {
            guard let index = bodyTypes.firstIndex(of: bodyType) else {
                bodyTypeSegmentedControl.selectedSegmentIndex = 0
                bodyTypeTextView.text = bodyTypeDescriptions[0]
                bodyTypeImageView.image = bodyTypeImages[0]
                return
            }
            bodyTypeSegmentedControl.selectedSegmentIndex = index
            bodyTypeTextView.text = bodyTypeDescriptions[index]
            bodyTypeImageView.image = bodyTypeImages[index]
            delegate?.setBodyType(bodyType: bodyType)
            
        } else {
            bodyTypeSegmentedControl.selectedSegmentIndex = 0
            bodyTypeTextView.text = bodyTypeDescriptions[0]
            bodyTypeImageView.image = bodyTypeImages[0]
        }
    }

    @IBAction func updateBodyType(_ sender: Any) {
        updateBodyType()
    }
    
    private func updateBodyType(){
        let index = bodyTypeSegmentedControl.selectedSegmentIndex
        if let bodyType = bodyTypeSegmentedControl.titleForSegment(at: index) {
            bodyTypeTextView.text = bodyTypeDescriptions[index]
            bodyTypeImageView.image = bodyTypeImages[index]
            self.bodyType = bodyType
            delegate?.setBodyType(bodyType: bodyType)
            updateView()
        }
    }

}

