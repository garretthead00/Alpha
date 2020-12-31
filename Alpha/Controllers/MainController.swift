//
//  MainController.swift
//  Alpha
//
//  Created by Garrett Head on 8/12/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit


class MainController: UITabBarController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("main tab loaded!!")
        print("with interface style: --- \(self.traitCollection.userInterfaceStyle.rawValue)")
       
        

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Trait collection has already changed
        super.traitCollectionDidChange(previousTraitCollection)

        
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Trait collection will change. Use this one so you know what the state is changing to.
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
