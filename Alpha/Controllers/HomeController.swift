//
//  HomeController.swift
//  Alpha
//
//  Created by Garrett Head on 8/18/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Manage Walkthrough
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        if !hasViewedWalkthrough {
            let sb = UIStoryboard(name: "Walkthrough", bundle: nil)
            if let pageVC = sb.instantiateViewController(withIdentifier: "WalkthroughPageController") as? WalkthroughController {
                self.present(pageVC, animated: true, completion: nil)
            }
        } else {
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}

