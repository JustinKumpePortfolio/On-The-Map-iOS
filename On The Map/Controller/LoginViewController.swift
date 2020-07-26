//
//  ViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/14/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let username = "jakumpe@kumpes.com"
        let password = "Sa1ntFlor1an2016"
        ApiClient.login(username: username ?? "", password: password ?? "", completion: loginResponse(success:error:))
    }
    
    func loginResponse(success: Bool, error: String){
        if success{
            ShowAlert.error(viewController: self, title: "Success", message: "Login Success")
        }else{
            ShowAlert.error(viewController: self, title: "Login Failed", message: error)
        }
    }

}

