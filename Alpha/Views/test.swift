//
//  test.swift
//  Alpha
//
//  Created by Garrett Head on 8/16/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

class SideMenuHeaderView: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
       
       var username : String? {
           didSet {
               updateView()
           }
       }
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           print("awake")
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
       
       private func updateView(){
           if let username = self.username {
               self.usernameLabel?.text = username
               print("updated with username: -- \(username)")
           }
           
           
       }
    
}
