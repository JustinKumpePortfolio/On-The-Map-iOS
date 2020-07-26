//
//  ClientHelpers.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/25/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

// MARK: Helpers

// substitute the key for the value that is contained within the method name
public func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
    if method.range(of: "{\(key)}") != nil {
        return method.replacingOccurrences(of: "{\(key)}", with: value)
    } else {
        return nil
    }
}

// given raw JSON, return a usable Foundation object
public func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?, _ errorMessage: String) -> Void) {
    
    var parsedResult: AnyObject! = nil
    do {
        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
    } catch {
        let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
        completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo),"")
    }
    
    completionHandlerForConvertData(parsedResult, nil,"")
}

public func removePaddedData(data: Data) -> Data {
    let range = 5..<data.count
    let newData = data.subdata(in: range) /* subset response data! */
    return newData
}


