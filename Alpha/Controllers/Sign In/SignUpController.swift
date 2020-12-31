//
//  SignUpController.swift
//  Alpha
//
//  Created by Garrett Head on 8/18/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class SignUpController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    
    
    // MARK: - Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        styleSignupControls()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func styleSignupControls(){
        
        // Customize username field
        let userNameBottomLayer = CALayer()
        userNameBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        userNameBottomLayer.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0).cgColor
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.addSublayer(userNameBottomLayer)
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderColor = .none
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
        
        // Customize confirmPassword field
        let confirmPasswordBottomLayer = CALayer()
        confirmPasswordBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.5)
        confirmPasswordBottomLayer.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0).cgColor
        confirmPasswordTextField.backgroundColor = UIColor.clear
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: confirmPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        confirmPasswordTextField.tintColor = UIColor.white
        confirmPasswordTextField.textColor = UIColor.white
        confirmPasswordTextField.layer.masksToBounds = true
        confirmPasswordTextField.layer.addSublayer(confirmPasswordBottomLayer)
       confirmPasswordTextField.layer.borderWidth = 1.0
       confirmPasswordTextField.layer.borderColor = .none
        
       registerButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
       registerButton.isEnabled = false
       validateTextFields()
    }
    
    // MARK: - Validation
    private func validateTextFields() {
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textFieldDidChange(){
        // checks any of the textfields has input
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            registerButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            registerButton.isEnabled = false
            return
        }
        registerButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerButton.isEnabled = true
    }
    
    // MARK: - Actions
    @IBAction func registerUserAccount(_ sender: Any) {
        view.endEditing(true)
        guard let username = usernameTextField.text else {
            return
        }
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.animationType = .multipleCirclePulse
        ProgressHUD.show("Registering...", interaction: false)
        AuthService.signUp(withEmail: email, username: username, password: password, onSuccess: {
            ProgressHUD.show(icon: .bolt)
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "hasViewedWalkthrough")
            self.performSegue(withIdentifier: "signinUser", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)
            print(error!)
        })
       
    }
    
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
