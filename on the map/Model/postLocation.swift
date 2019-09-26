//
//  postLocation.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation

struct PostLocation : Codable{
    let uniqueKey :String
    let firstName :String
    let lastName  :String
    let mapString :String
    let mediaURL  :String
    let latitude  :Double
    let longitude :Double
    
    enum CodingKeys: String, CodingKey {
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude  

    }


}
