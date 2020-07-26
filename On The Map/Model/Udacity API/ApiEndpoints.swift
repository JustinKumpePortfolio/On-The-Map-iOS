//
//  ApiEndpoints.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation

enum ApiEndpoints {
    
    case login
    case logout
    case getStudentPins(Int)
    case getUserData
    case addLocation
//    case updateLocation
    
    var urlValue: String {
        switch self {
        case .login, .logout:
            return Constants.UdacityUrls.api + "/session"
        case .getStudentPins(let limit):
            return Constants.UdacityUrls.api + "/StudentLocation?order=-updatedAt&limit=\(limit)"
        case .getUserData:
            return Constants.UdacityUrls.api + "/users/\(AuthUser.userId)"
        case .addLocation:
            return Constants.UdacityUrls.api + "/StudentLocation"
/*        case .updateLocation:
            return Constants.UdacityUrls.Api + "/StudentLocation/\(StudentModel.userObjectId!)"
 */       }
    }
    
    var url: URL {
        return URL(string: urlValue)!
    }
}
