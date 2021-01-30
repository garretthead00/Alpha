//
//  HydrationTargetView.swift
//  Alpha
//
//  Created by Garrett Head on 12/31/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class HydrationTargetView: UITableViewCell {

    @IBOutlet weak var waterDrankLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    var hydrationTargetViewModel : HydrationTargetViewModel? { didSet { updateView() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        waterDrankLabel.text = "--"
        targetLabel.text = "--"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView(){
        if let targetViewModel = self.hydrationTargetViewModel {
            waterDrankLabel.text = "\(Int(targetViewModel.waterDrank)) \(targetViewModel.unit)"
            targetLabel.text = "\(Int(targetViewModel.targetValue)) \(targetViewModel.unit)"
        }
        
    }

}
