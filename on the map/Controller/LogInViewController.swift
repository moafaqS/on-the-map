//
//  ViewController.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 19/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController ,  UITextFieldDelegate{
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        API.getSessionID(username: "moka@gmail.com", password: "moafaq12345") { (done, error) in
            if done{
                print(API.Auth.sessionId)
            }else{
                print(error)
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        return true
        
    }

    
}

}
