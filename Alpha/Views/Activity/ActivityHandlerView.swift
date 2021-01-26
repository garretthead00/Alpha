//
//  ActivityHandlerView.swift
//  Alpha
//
//  Created by Garrett Head on 1/22/21.
//  Copyright © 2021 Garrett Head. All rights reserved.
//

import UIKit

class ActivityHandlerView: UITableViewCell {
    @IBOutlet weak var handlerIconImageView: UIImageView!
    @IBOutlet weak var handlerNameLabel: UILabel!
    @IBOutlet weak var handlerValueLabel: UILabel!
    
    var viewModel : ActivityTargetHandlerViewModel? { didSet { updateView() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView(){
        if let viewModel = self.viewModel {
            handlerIconImageView.image = viewModel.icon
            handlerNameLabel.text = viewModel.name
            handlerValueLabel.text = "\(viewModel.value) \(viewModel.unit.symbol)"
        }
    }

}
