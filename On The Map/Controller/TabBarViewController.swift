//
//  TabBarViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/25/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
//    MARK: Buttons
    @IBOutlet weak var buttonRefresh: UIButton!
    @IBOutlet weak var buttonAddItem: UIButton!
    
//    MARK: Custom Activity Indicator
    let indicatorActivity = Spinner(frame: CGRect(x: 0, y: 0, width: 100, height: 100), image: UIImage(named: "loading")!)
    

//    MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
        enableUi(true)
        getLocations()
    }
    
    
//    MARK: Clicked Add
    @IBAction func clickedAdd(){
        performSegue(withIdentifier: "segueAddStudent", sender: self)
    }
    
//    MARK: Clicked Refresh
    @IBAction func clickedRefresh(){
        getLocations()
    }
    
    
//    MARK: Enable UI
//    Enables/Disables UI. When UI is disabled activity indicator is active
    func enableUi(_ enable:Bool){
        performUIUpdatesOnMain {
            activityIndicator(self.view, !enable, self.indicatorActivity)
            self.buttonAddItem.isEnabled = enable
            self.buttonAddItem.isEnabled = enable
        }
        
    }
    
//    MARK: Get Location Data
    func getLocations(){
        enableUi(false)
        ApiClient.getLocations() { (results, error, errorMessage) in
            performUIUpdatesOnMain {
                self.enableUi(true)
                guard error == nil else{
                    ShowAlert.error(viewController: self, title: "Error", message: "An error occured while retrieving data.")
                    return
                }
                
                if let _ = results{
                    
//                    Sends notification to ListView and MapView that data has been updated
                    NotificationCenter.default.post(name: .buildList, object: nil)
                    NotificationCenter.default.post(name: .buildMap, object: nil)
                }else{
                    ShowAlert.error(viewController: self, title: "No Data", message: "No Data Returned")
                }
            }
        }
        
    }
    

}
