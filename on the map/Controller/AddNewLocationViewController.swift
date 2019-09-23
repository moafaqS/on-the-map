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
        enableActivity(enable: true)
        
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
