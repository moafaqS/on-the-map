//
//  SessionIdResponse.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation


struct loginResponse : Codable{
    var account : Account
    var session : Session
    
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
    
}

struct Account : Codable{
    var registered : Bool
    var key : String
}

struct Session : Codable{
    var id : String
    var expiration : String
}
