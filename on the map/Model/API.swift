//
//  API.swift
//  on the map
//
//  Created by moafaq waleed simbawa on 20/01/1441 AH.
//  Copyright © 1441 moafaq. All rights reserved.
//

import Foundation

class API {
    
    struct Auth {
        static var sessionId = ""
        static var accountId = ""
    }
    
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentLocation
        case postStudentLocation
        case getSessionID
        case puttingStudentLocation(String)
        case GettingPublicUserData(String)
        case logout

        
        var stringValue: String {
            switch self {
            case .getSessionID : return Endpoints.base + "/session"
            case .getStudentLocation : return Endpoints.base + "/StudentLocation" + "?limit=100&order=-updatedAt"
            case .postStudentLocation : return Endpoints.base + "/StudentLocation"
            case .puttingStudentLocation(let objectId) : return Endpoints.base + "/StudentLocation/\(objectId)"
            case .GettingPublicUserData(let userId) : return Endpoints.base + "/users/\(userId)"
            case .logout : return Endpoints.base + "/session"
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getUserData(completion : @escaping (PublicUserData?,Error?) -> Void){
        
        let request = URLRequest(url: Endpoints.GettingPublicUserData(Auth.accountId).url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else{
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let range : Range = 5..<data.count
            let newData = data.subdata(in: range)
            do {
                let responseObject = try decoder.decode(PublicUserData.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                    
                }
            }catch{
                completion(nil, error)
            }
        }
        task.resume()
        
    }
    
    class func getStudentsLocation(completion : @escaping ([StudentInformation],Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(locationResults.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject.results, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
                
            }
        }
        task.resume()
        

    }
    
    class func postStudentLocation(firstName: String, lastName: String, latitude: Double, longitude: Double, mapString: String, mediaURL: String , uniqueKey: String , completion : @escaping (Bool,Error?) -> Void) {
        
        let location = PostLocation(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        

        var request = URLRequest(url: Endpoints.postStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(location)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(false,error)
                return
            }else{
                completion(true,nil)
            }
           
        }
        task.resume()

    
    }
   
    class func login(username: String, password: String , completion : @escaping (Bool,Error?)->Void) {
        let loginRequest = LoginRequest(username: username, password: password)
        let requestBody = LogInRequestBody(loginRequest: loginRequest)
        let body =  try! JSONEncoder().encode(requestBody)
    
        var request = URLRequest(url: Endpoints.getSessionID.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
       
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else{
                completion(false, error)
                return
            }
            let decoder = JSONDecoder()
            let range : Range = 5..<data.count
            let newData = data.subdata(in: range)

            do {
            let responseObject = try decoder.decode(loginResponse.self, from: newData)
                Auth.accountId =  responseObject.account.key
                Auth.sessionId = responseObject.session.id
                DispatchQueue.main.async {
                    completion(true, nil)
                }
             }catch{
                 completion(false, error)
            }


    }
       task.resume()
    
}
    
    
    class func logout(completion : @escaping (Bool,Error?) -> Void){
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie
                break
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(false,error)
                return
            }else{
                let range : Range = 5..<data!.count
                let newData = data!.subdata(in: range)
                print(String(data: newData, encoding: .utf8)!)
                completion(true,nil)
            }
            
        }
        task.resume()
    }
}
