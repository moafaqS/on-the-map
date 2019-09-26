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
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableLogInUi(enable: true)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        
        enableLogInUi(enable: false)
        
        API.login(username: emailField.text!, password: passwordField.text!) { (done, error) in
            if done{
                self.performSegue(withIdentifier: "toStudentsLocationSegue", sender: nil)
                self.enableLogInUi(enable: true)
                self.clearTextFields()
            }else{
                self.enableLogInUi(enable: true)
                self.handleError(error: error!)
                self.clearTextFields()
            }
        }
        
    }
    
    func clearTextFields(){
        DispatchQueue.main.async {
            self.passwordField.text = ""
        }
       
    }
    
    func handleError(error : Error) {
        
        if error.localizedDescription == "The Internet connection appears to be offline."{
            errorMessage(message: "failure to connect")
        }else{
            errorMessage(message: " wrong email or password")
        }

        
        
        
    }
    
    func errorMessage(message : String){
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
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

extension LogInViewController{
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
            view.frame.origin.y = 0
            view.frame.origin.y -= getKeyboardHeight(notification)/2 + 80
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
