//
//  StudentLocationTableViewVC.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class ListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
   

    @IBOutlet weak var tableView: UITableView!
    
    var studentsArray = [StudentInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        API.getStudentsLocation { (array, error) in
            if error == nil{
                self.studentsArray = array
                self.tableView.reloadData()
            }
            else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "failure", message: "The app failed to download student locations.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                
            }

        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
            as! studentCell
        
        cell.name.text = studentsArray[indexPath.row].firstName + " " + studentsArray[indexPath.row].lastName
        cell.imageUrl.image = UIImage(named: "icons8-user-location-64")
        
        cell.cellView.backgroundColor = UIColor.white
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        cell.cellView.layer.borderWidth = 0.1
        cell.cellView.layer.cornerRadius = 8
        cell.cellView.clipsToBounds = true


        

        return cell 
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: studentsArray[indexPath.row].mediaURL) else { return }
        print(url)
        UIApplication.shared.open(url)
    }
    
    

   

}
