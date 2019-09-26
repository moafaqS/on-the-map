//
//  StudentLocationTableViewVC.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import UIKit

class ListViewController: LocationsArray , UITableViewDelegate , UITableViewDataSource{
   

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStudentLocation()
    }
    
    override func refresh() {
         self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stutendsLocation.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
            as! studentCell
        
        cell.name.text = stutendsLocation[indexPath.row].firstName + " " + stutendsLocation[indexPath.row].lastName
        cell.imageUrl.image = UIImage(named: "icons8-user-location-64")
        
        cell.cellView.backgroundColor = UIColor.white
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        cell.cellView.layer.borderWidth = 0.1
        cell.cellView.layer.cornerRadius = 8
        cell.cellView.clipsToBounds = true


        return cell 
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: stutendsLocation[indexPath.row].mediaURL) else { return }
        print(url)
        UIApplication.shared.open(url)
    }
    
    

   

}
