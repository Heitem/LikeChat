//
//  LoginVC.swift
//  LikeChat
//
//  Created by Heitem OULED-LAGHRIYEB on 10/30/17.
//  Copyright © 2017 Heitem OULED-LAGHRIYEB. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text, (email.characters.count > 0 && password.characters.count > 0) {
            
            AuthService.instance.login(email: email, password: password, onComplete: { (errorMsg, data) in
                guard errorMsg == nil else {
                    let alert = UIAlertController(title: "Error authentication", message: errorMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            let alert = UIAlertController(title: "Username and password required.", message: "You must enter both username and password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
