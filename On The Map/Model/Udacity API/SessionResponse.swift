//
//  SessionResponse.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/21/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

struct SessionResponse {
    let account: Account
    let session: Session
    
    
    struct Account {
        let registered: Bool
        let key: String
    }
    
    struct Session {
        let id: String
        let expiration: String
    }
}
