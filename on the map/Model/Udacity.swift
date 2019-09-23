//
//  Udacity.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation

struct LogInRequestBody : Codable{
    let loginRequest : LoginRequest
    
    enum CodingKeys: String, CodingKey {
        case loginRequest = "udacity"
    }
    
}
