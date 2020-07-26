//
//  PinData.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

struct StudentInformation {
    static var sharedInstance = StudentInformation(dictionary: [:])
    
    var firstName: String?
    var lastName: String?
    var longitude: Double?
    var latitude: Double?
    var mapString: String?
    var mediaURL: String?
    var uniqueKey: String?
    var createdAt: String?
    var updatedAt: String?
    
    init(dictionary: [String:AnyObject]){
        self.firstName = dictionary[Constants.UdacityApiKeys.firstName] as? String
        self.lastName = dictionary[Constants.UdacityApiKeys.lastName] as? String
        self.longitude = dictionary[Constants.UdacityApiKeys.longitude] as? Double
        self.latitude = dictionary[Constants.UdacityApiKeys.latitude] as? Double
        self.mapString = dictionary[Constants.UdacityApiKeys.mapString] as? String
        self.mediaURL = dictionary[Constants.UdacityApiKeys.mediaURL] as? String
        self.uniqueKey = dictionary[Constants.UdacityApiKeys.uniqueKey] as? String
        self.createdAt = dictionary[Constants.UdacityApiKeys.createdAt] as? String
        self.updatedAt = dictionary[Constants.UdacityApiKeys.updatedAt] as? String
        
        if mediaURL?.prefix(7) != "" && mediaURL?.prefix(7) != "http://" && mediaURL?.prefix(8) != "https://" && mediaURL!.count >= 4{
            self.mediaURL = "http://\(self.mediaURL!)"
        }
    }
    
    static var studentLocationData: [StudentInformation] = []
}
