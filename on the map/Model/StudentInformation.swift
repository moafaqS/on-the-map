//
//  StudentLocation.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation

struct StudentInformation : Codable{
    let createdAt : String
    let firstName : String
    let lastName : String
    let latitude : Double
    let longitude : Double
    let mapString : String
    let mediaURL : String
    let objectId : String
    let uniqueKey : String
    let updatedAt : String
    
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL
        case objectId
        case uniqueKey
        case updatedAt
    }
    
}
