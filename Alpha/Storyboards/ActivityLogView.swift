//
//  ActivityLogView.swift
//  Alpha
//
//  Created by Garrett Head on 12/27/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class ActivityLogView: UITableViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    var activityLogViewModel : ActivityLogViewModel? { didSet { updateView() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    private func updateView(){
        if let viewModel = activityLogViewModel {
            nameLabel.text = viewModel.name
            iconImageView.image = viewModel.icon
            timestampLabel.text = viewModel.timestamp
            valueLabel.text = "\(viewModel.value)"
        }
    }
}
