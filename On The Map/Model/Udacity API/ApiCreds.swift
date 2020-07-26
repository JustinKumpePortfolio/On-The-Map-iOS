//
//  ApiCreds.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

struct ApiCreds {
    let udacity: Udacity
    
    struct Udacity {
        let username: String
        let password: String
        var jsonBody: String {
            return "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        }
    }
    
    
}
