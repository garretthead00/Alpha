//
//  TargetedHandlerStackView.swift
//  Alpha
//
//  Created by Garrett Head on 2/6/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

class TargetedHandlerStackView: UITableViewCell {

    @IBOutlet weak var handlerIconImageView: UIImageView!
    @IBOutlet weak var handlerNameLabel: UILabel!
    @IBOutlet weak var handlerValueLabel: UILabel!
    @IBOutlet weak var targetValueLabel: UILabel!
    
    var viewModel : TargetedHandlerStackViewModel? { didSet { updateView() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView(){
        if let vm = self.viewModel {
            handlerIconImageView.image = vm.icon
            handlerNameLabel.text = vm.name
            handlerValueLabel.text = "\(Int(vm.value)) \(vm.unit)"
            targetValueLabel.text = "\(Int(vm.targetValue)) \(vm.unit)"
        }
        
    }

}
