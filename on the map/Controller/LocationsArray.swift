//
//  LocationsArray.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 27/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class LocationsArray: UIViewController {


    var stutendsLocation = [StudentInformation]()
    
    
    
    func getStudentLocation()  {
        DispatchQueue.main.async {
            API.getStudentsLocation { (array, error) in
                if error == nil{
                    self.stutendsLocation = array
                    self.refresh()
                }
                else{
                    let alert = UIAlertController(title: "failure", message: "The app failed to download student locations.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                
            }
            
        }
    }
    
    func refresh() {}
}
