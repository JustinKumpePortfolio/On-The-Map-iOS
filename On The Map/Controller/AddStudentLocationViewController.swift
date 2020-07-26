//
//  AddStudentLocationViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/26/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit
import MapKit

class AddStudentLocationViewController: UIViewController, MKMapViewDelegate{
    
//    MARK: Properties
    var stringLocation:String?
    var stringUrl:String?
    var latitude:Double?
    var longitude:Double?
    
//    MARK: Map View
    @IBOutlet weak var viewMap: MKMapView!
    
//    MARK: Buttons
    @IBOutlet weak var buttonSubmit: UIButton!
    
//    MARK: Custom Activity Indicator
    let indicatorActivity = Spinner(frame: CGRect(x: 0, y: 0, width: 100, height: 100), image: UIImage(named: "loading")!)
    
//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap.delegate = self
    }
    
//    MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropPin()
        enableUi(true)
    }
    
//    MARK: Drop Pin
    func dropPin(){
        let annotation = MKPointAnnotation()
        
        if let lat = latitude, let long = longitude, let title = stringLocation, let subtitle = stringUrl{
            let coordinate = CLLocationCoordinate2DMake(lat, long)
            annotation.coordinate = coordinate
            annotation.title = title
            annotation.subtitle = subtitle
            viewMap.addAnnotation(annotation)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            viewMap.setRegion(region, animated: true)
            
        }else{
            ShowAlert.error(viewController: self, title: "Error", message: "Missing Pin Data!")
            
        }
    }

//    MARK: Pressed Submit
    @IBAction func pressedSubmit(){
        enableUi(false)
        ApiClient.getUserData() { (response, error, errorMessage) in
            guard error == nil else{
                performUIUpdatesOnMain {
                    self.enableUi(true)
                    ShowAlert.error(viewController: self, title: "Error", message: "Unable to retrieve user data.")
                    print(error!.localizedDescription)
                }
                return
            }
            
            ApiClient.postLocation(uniqueKey: AuthUser.userId, firstName: AuthUser.userFirstName, lastName: AuthUser.userLastName, mapString: self.stringLocation ?? "", mediaUrl: self.stringUrl ?? "", lat: self.latitude ?? 0, long: self.longitude ?? 0) { (success, error) in
                
                if success{
                    performUIUpdatesOnMain {
                        self.enableUi(true)
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                }else{
                    performUIUpdatesOnMain {
                        self.enableUi(true)
                        ShowAlert.error(viewController: self, title: "Error", message: "An Error Occured Posting Your Pin Data")
                    }
                }
            }
            
        }
    }
    
//    MARK: Enable UI
//    Enables/Disables UI. When UI is disabled activity indicator is active
    func enableUi(_ enable:Bool){
        performUIUpdatesOnMain {
            activityIndicator(self.view, !enable, self.indicatorActivity)
            self.buttonSubmit.isEnabled = enable
        }
            
    }

}
