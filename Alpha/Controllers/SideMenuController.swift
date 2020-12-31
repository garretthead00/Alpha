//
//  SideMenuController.swift
//  Alpha
//
//  Created by Garrett Head on 8/14/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SideMenuController: UITableViewController {
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else {
                return
        }
        Database.database().reference().child("users").child(currentUser.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let data = snapshot.value as? [String: Any] {
                let username = data["username"] as? String ?? ""
                self.username.text = username
            }
        })
    }
    
    // MARK: - Outlets
    @IBAction func didTapCloseMenu(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 128
        } else {
            return 44
        }
    }


    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Bio" {
//            let bioVC = segue.destination as! ViewController
//        }
    }
    

}


