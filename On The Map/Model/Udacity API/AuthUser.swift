//
//  AuthUser.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

//Struct holds Authenticated User's Info
struct AuthUser {
    static var sessionId = ""
    static var userId = ""
    static var userFirstName = ""
    static var userLastName = ""
    
    init(userInfo: Bool, dictionary: [String:AnyObject]) {
        if userInfo{
            AuthUser.userFirstName = dictionary["first_name"] as! String
            AuthUser.userLastName = dictionary["last_name"] as! String
        }else{
            AuthUser.sessionId = dictionary["session"]!["id"] as! String
            AuthUser.userId = dictionary["account"]!["key"] as! String
        }
    }
    
    static func logout(){
        sessionId = ""
        userId = ""
        userFirstName = ""
        userLastName = ""
    }
}
