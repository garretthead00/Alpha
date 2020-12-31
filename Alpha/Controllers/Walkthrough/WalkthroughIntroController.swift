//
//  WalkthroughIntroController.swift
//  Alpha
//
//  Created by Garrett Head on 9/19/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The Walkthrough Intro Controller is a dynamic controller that presents and describes the application.
// This controller is the first introduction to the application that the user sees after registration.
//
// The main features of the controller are the image, title and description. Each variable is passed in
// by the WalkthroughPageController.
//
// Each scene of the walkthrough intro describes the application to the user.
//

import UIKit

class WalkthroughIntroController: UIViewController {

    var introImage : String?
    var introTitle : String?
    var introCaption : String?
    var index : Int?
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView(){
        if let imageView = imageView {
            if let imageName = introImage {
                if let image = UIImage(named: imageName) {
                    imageView.image = image
                }
            }
        }

        if let titleLabel = titleLabel {
            if let title = introTitle {
                titleLabel.text = title
            }
        }

        if let captionLabel = captionLabel {
            if let caption = introCaption {
                captionLabel.text = caption
            }
        }
    }
}


