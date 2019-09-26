//
//  AddNewLocationViewController.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 23/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class AddNewLocationViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var locationLabel: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableActivity(enable: false)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        unsubscribeFromKeyboardNotifications()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.locationLabel.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        locationLabel.text = ""
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func enableActivity(enable : Bool){
        activityIndicator.isHidden = !enable
        enable ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
    }
    
    @IBAction func findOnTheMap(_ sender: Any) {

        if locationLabel.text == ""{
                enableActivity(enable: false)
                let alert = UIAlertController(title: "Required field", message: "You must write a location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            
        }else{
            enableActivity(enable: true)
            performSegue(withIdentifier: "toNewLocation", sender: locationLabel.text)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewLocationMapViewController
        {
            let vc = segue.destination as? NewLocationMapViewController
            vc?.searchText = sender as! String
        }
    }
    
}

extension AddNewLocationViewController{
    
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

