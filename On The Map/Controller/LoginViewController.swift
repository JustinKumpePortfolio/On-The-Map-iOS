//
//  LoginViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/14/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit
import Reachability

class LoginViewController: UIViewController {
    
//    MARK: Fields
    @IBOutlet weak var fieldUsername: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
//    MARK: Image Views
    @IBOutlet weak var imageLogo: UIImageView! //Logo Image will also be used as activity indicator
    
//    MARK: Buttons
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignup: UIButton!
    
//    MARK: Reachability
    let reachability = try! Reachability()

//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fieldUsername.text = "jakumpe@kumpes.com"
        self.fieldPassword.text = "Sa1ntFlor1an2016"
        //self.pressedLogin(self)
    }
    
//    MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ApiClient.logout(){ (success,error) in
            
        }
        
//        Start Notifications for Network Reachability Changes
        DispatchQueue.global(qos: .background).async {
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(note:)), name: .reachabilityChanged, object: self.reachability)
        do{
            try self.reachability.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
        }
        
//        Enable UI
        enableUI(true)
    }
    
    
//    MARK: Enable UI
//    We are also going to start/stop activity indicator in this func
    func enableUI(_ enable: Bool){
        RotateImage.rotate(!enable, imageLogo, hideWhenStopped: false)
        fieldUsername.isEnabled = enable
        fieldPassword.isEnabled = enable
        buttonLogin.isEnabled = enable
        buttonSignup.isEnabled = enable
    }
    
//    MARK: Pressed Login
    @IBAction func pressedLogin(_ sender: Any){
//        Disable UI to indicate activity
        enableUI(false)
        
        if reachability.connection != .unavailable{
            //        Call Login API
            ApiClient.login(username: self.fieldUsername.text ?? "", password: self.fieldPassword.text ?? "", completion: self.loginResponse(success:error:))
        }else{
            ShowAlert.error(viewController: self, title: "Network Connection Error", message: "Network is unavailable. Please ensure you are connected to the internet.")
            self.enableUI(true)
        }
            
    }
    
//    MARK: Login Response
//    Handles user login response
    func loginResponse(success: Bool, error: String){
        if success{
            // Login success
            performSegue(withIdentifier: "segueLogin", sender: nil)
        }else{
            ShowAlert.error(viewController: self, title: "Login Failed", message: error)
        }
        enableUI(true)
    }
    
//    MARK: Pressed Signup
    @IBAction func pressedSignup(){
        launchURL(Constants.UdacityUrls.signup)
    }
    
    
//    MARK: Reachability Changed
//    Handles network connection issues
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network Unreachable")
        ShowAlert.error(viewController: self, title: "Network Unreachable", message: "Network is unreachable. Please check your internet connection.")
      case .none:
        print("Error")
        }
    }

}

