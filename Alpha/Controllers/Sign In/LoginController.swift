//
//  LoginController.swift
//  Alpha
//
//  Created by Garrett Head on 8/18/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LoginController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    // MARK: - Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        styleLoginControls()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "signinUser", sender: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
        
    private func styleLoginControls(){

        // Customize email field
        let emailBottomLayer = CALayer()
        emailBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        emailBottomLayer.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0).cgColor
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.addSublayer(emailBottomLayer)
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = .none
        
        // Customize password field
        let passwordBottomLayer = CALayer()
        passwordBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.5)
        passwordBottomLayer.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0).cgColor
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.addSublayer(passwordBottomLayer)
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = .none
        
        loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
        loginButton.isEnabled = false
        validateTextFields()
    }
    
    
    // MARK: - Validation
    private func validateTextFields() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textFieldDidChange(){
        // checks any of the textfields has input
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            loginButton.isEnabled = false
            return
        }
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.isEnabled = true
    }
    
    
    // MARK: - Actions
    @IBAction func didTapLoginButton(_ sender: Any) {
        view.endEditing(true)
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        ProgressHUD.show("Logging in...", interaction: false)
        AuthService.signIn(withEmail: email, password: password, onSuccess: {
            ProgressHUD.show(icon: .bolt)
            self.performSegue(withIdentifier: "signinUser", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)
            print(error!)
        })
        
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
