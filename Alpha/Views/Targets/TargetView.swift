//
//  TargetView.swift
//  Alpha
//
//  Created by Garrett Head on 10/31/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class TargetView: UITableViewCell {

    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetValueLabel: UILabel!
    
    var targetIcon : UIImage? { didSet { updateView() } }
    var targetName : String?
    var targetValue : Double?
    
    var userTarget : UserTarget? { didSet { updateView() } }
    
    var delegate : UserTargetDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        targetImage.image = nil
        targetLabel.text = ""
        targetValueLabel.text = "0"
    }

    

    private func updateView(){        
        if let target = self.userTarget {
            targetImage.image = target.icon
            targetLabel.text = target.name
            if let value = target.value as? Double { targetValueLabel.text = "\(Int(value)) \(target.unit ?? "")" }
        }
    }
}

