//
//  WalkthroughFinaleController.swift
//  Alpha
//
//  Created by Garrett Head on 9/19/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughFinaleController is the fair well scene of the walkthrough.
// This controller consists of a simple scene and button to complete the walkthrough.
//
// The walkthrough is completed once the hasViewedWalkthrough variable is set by selecting the
// completion button. From here the user is taken to the main view of the application.
//

import UIKit

class WalkthroughFinaleController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var delegate : WalkthroughDelegate?
    
    var heading : String?
    var message : String = "Hit the prev button to go back if you change your mind on anything.\nDon't worry. You can always change it later.\n\nHit Go when you're ready!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView(){
        if let heading = self.heading {
            self.headingLabel.text = heading
        }
        self.messageLabel.text = self.message
    }
    
    @IBAction func finishedWithWalkThrough(_ sender: Any) {
        
        // Set UserDefaults
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "hasViewedWalkthrough")
        
        // Save to database
        delegate?.saveBio()
        
        // Transition to Main View
        //self.performSegue(withIdentifier: "signinUser", sender: nil)
        
    }
}
