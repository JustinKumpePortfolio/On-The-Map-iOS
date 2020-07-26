//
//  Client.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

class ApiClient {


    
    // shared session
    public static var session = URLSession.shared
    
    
    class func taskForGETRequest(removePadding: Bool = false, url: URL, completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?, _ errorMessage: String) -> Void) -> URLSessionDataTask {
            taskForRequest(httpMethod: "GET", removePadding: removePadding, url: url, jsonBody: "", completionHandler: completionHandler)
    }
    
    class func taskForPOSTRequest(removePadding: Bool = true, url: URL, jsonBody: String, completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?, _ errorMessage: String) -> Void) -> URLSessionDataTask {
            taskForRequest(httpMethod: "POST", removePadding: removePadding, url: url, jsonBody: jsonBody, completionHandler: completionHandler)
    }
    
    class func taskForPUTRequest(url: URL, jsonBody: String, completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?, _ errorMessage: String) -> Void) -> URLSessionDataTask {
            taskForRequest(httpMethod: "PUT", removePadding: true, url: url, jsonBody: jsonBody, completionHandler: completionHandler)
    }
    
    class func taskForRequest(httpMethod: String, removePadding: Bool, url: URL, jsonBody: String, completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?, _ errorMessage: String) -> Void) -> URLSessionDataTask {
//        Build the URL, Configure the request
        let request = NSMutableURLRequest(url: url)
        
        if httpMethod != "GET"{
            request.httpMethod = httpMethod
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        }
        
//        Make the request
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(nil, NSError(domain: "taskFor\(httpMethod)Method", code: 1, userInfo: userInfo),error)
            }
            
//            GUARD: Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
//            GUARD: Did we get a successful 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                print("StatusCode: \(statusCode)")
                var message = ""
                switch statusCode {
                case 400:
                    message = "No Credentials Supplied. Please enter credentials"
                case 403:
                    message = "Username/Password is Invalid or you do not have an account"
                default:
                    message = "An Unknown Error Occured"
                }
                sendError(message)
                
                return
            }
 
//            GUARD: Was there any data returned?
            guard var data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            if removePadding{
                data = removePaddedData(data: data)
            }
            
//            Parse the data and use the data (happens in completion handler)
            convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
//        Start the request
        task.resume()
        
        return task
    }
    
}
