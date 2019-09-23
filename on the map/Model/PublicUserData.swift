//
//  PublicUserData.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 24/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation


struct PublicUserData : Codable{
    var lastName : String
    var firstName : String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
    
    
}

