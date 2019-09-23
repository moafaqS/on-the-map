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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
    }
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableLogInUi(enable: true)
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        
        enableLogInUi(enable: false)
        
        API.login(username: emailField.text!, password: passwordField.text!) { (done, error) in
            if done{
                self.performSegue(withIdentifier: "toStudentsLocationSegue", sender: nil)
            }else{
                self.enableLogInUi(enable: true)
                self.handleError()
            }
        }
        
    }
    
    func handleError() {

        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "incorrect credentials", message: "wrong email or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self!.present(alert, animated: true)
            
        }
        
        
    }
    
    func enableLogInUi(enable : Bool){
        DispatchQueue.main.async {
        self.login.isEnabled = enable
        self.emailField.isEnabled = enable
        self.passwordField.isEnabled = enable
        self.activityIndicator.isHidden = enable
        enable ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
        }
    }
    


}
