//
//  NewLocationMapViewController.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 23/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit
import MapKit

class NewLocationMapViewController: UIViewController, MKMapViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var linkToShare: UITextField!
    var searchText = ""
    var selectedPin:MKPlacemark? = nil
    
    var matchingItems:[MKMapItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        linkToShare.delegate = self
        findLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.linkToShare.resignFirstResponder()
        return true
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        linkToShare.text = ""
    }
    
    
    func findLocation(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error != nil{
                
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: "failure", message: "failed to find location", preferredStyle: .alert)
               
                    alert.addAction(UIAlertAction(title: "ok", style:.default, handler: { (UIAlertAction) in
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                        
                    }))
                    self.present(alert, animated: true)
                }
                
            }else{
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.dropPinZoomIn(placemark: response.mapItems[0].placemark)
  
            }
            
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
     
        API.getUserData { (user, error) in
            if user != nil{
                API.postStudentLocation(firstName: user!.firstName, lastName: user!.lastName, latitude:(self.selectedPin?.coordinate.latitude)!, longitude: (self.selectedPin?.coordinate.longitude)!, mapString: self.searchText, mediaURL: self.linkToShare.text!, uniqueKey: API.Auth.accountId, completion: { (done, error) in
                    
                    if(done){
                        print("sucess")
                         DispatchQueue.main.async {
                            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }else{
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "failure", message: "The app failed to post new location", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }
                    }
                    
                })
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "failure", message: "The app failed to post new location", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }
            }
            
        }

    }
    
    



extension NewLocationMapViewController {
    
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
