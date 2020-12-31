//
//  ActivityDataView.swift
//  Alpha
//
//  Created by Garrett Head on 12/24/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class ActivityDataView: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var icon : UIImage? { didSet { updateView() } }
    var name : String? { didSet { updateView() } }
    var value : Double? { didSet { updateView() } }
    
    var userTarget : UserTarget? { didSet { updateView() } }
    
    var delegate : UserTargetDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.image = nil
        nameLabel.text = ""
        valueLabel.text = "0"
    }

    

    private func updateView(){
        if let name = self.name { nameLabel.text = name }
        if let value = self.value { valueLabel.text = "\((value*100).rounded()/100) g" }
        if let icon = self.icon { iconImageView.image = icon }
    }

}
