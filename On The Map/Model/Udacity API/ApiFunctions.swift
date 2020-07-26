//
//  ApiFunctions.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/25/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

extension ApiClient{
    
//    MARK: Login
//    Logs in user
    class func login(username: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let apiCreds = ApiCreds.Udacity.init(username: username, password: password)
        let body = apiCreds.jsonBody
        _ = taskForPOSTRequest(url: ApiEndpoints.login.url, jsonBody: body) { (response, error, errorMessage) in
            guard let response = response else {
                DispatchQueue.main.async {
                    completion(false, errorMessage)
                }
                
                return
            }
            
                _ = AuthUser.init(userInfo: false, dictionary: response as! [String : AnyObject])
            DispatchQueue.main.async {
                completion(true,"")
            }
        }
    }
    
//    MARK: getLocations
//    Gets Student location data
    class func getLocations(_ completionHandler: @escaping (_ locations: [StudentInformation]?, _ error: NSError?, _ errorMessage: String?) -> Void){
        
        let limit = 100
        
        _ = taskForGETRequest(url: ApiEndpoints.getStudentPins(limit).url) { (response, error, errorMessage) in
            guard error == nil else{
                completionHandler(nil, error, errorMessage)
                return
            }
            
            if let response = response{
                let dictionary = response["results"]!! as! [[String:AnyObject]]
                StudentInformation.studentLocationData = []
                for i in 0 ..< dictionary.count{
                    let result = StudentInformation.init(dictionary: dictionary[i])
                    StudentInformation.studentLocationData.append(result)
                }
                completionHandler(StudentInformation.studentLocationData,nil,"")
                
            }
        }
    }
    
//    MARK: getUserData
//    Gets User personal data
    class func getUserData(_ completionHandler: @escaping (_ locations: [StudentInformation]?, _ error: NSError?, _ errorMessage: String?) -> Void){
        
        _ = taskForGETRequest(removePadding: true, url: ApiEndpoints.getUserData.url) { (response, error, errorMessage) in
            guard error == nil else{
                completionHandler(nil, error, errorMessage)
                return
            }
            
            if let response = response{
                print(response)
                let dictionary = response as! [String:AnyObject]
                _ = AuthUser.init(userInfo: true, dictionary: dictionary)
                completionHandler(StudentInformation.studentLocationData,nil,"")
            }
        }
    }
    
//    MARK: postLocation
//    Posts user's location and link to database
    class func postLocation(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaUrl: String, lat: Double, long: Double, completion: @escaping (Bool, String) -> Void) {
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\", \"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaUrl)\", \"latitude\": \(lat), \"longitude\": \(long)}"

        _ = taskForPOSTRequest(removePadding: false, url: ApiEndpoints.addLocation.url, jsonBody: jsonBody) { (response, error, errorMessage) in
            guard let _ = response else {
                DispatchQueue.main.async {
                    completion(false, errorMessage)
                    print("Error")
                    print(errorMessage)
                }
                
                return
            }
            
                
            DispatchQueue.main.async {
                completion(true,"")
            }
        }
    }
    
//    MARK: Logout
//    Logs user out of session
    class func logout(completion: @escaping (Bool, String) -> Void) {
        let body = ""
        _ = taskForDELETERequest(url: ApiEndpoints.logout.url, jsonBody: body) { (response, error, errorMessage) in
            guard let _ = response else {
                DispatchQueue.main.async {
                    completion(false, errorMessage)
                }
                
                return
            }

            DispatchQueue.main.async {
                AuthUser.logout()
                completion(true,"")
            }
        }
    }
}
