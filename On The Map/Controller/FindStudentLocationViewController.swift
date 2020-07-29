//
//  FindStudentLocationViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/26/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit
import MapKit

class FindStudentLocationViewController: UIViewController {
    
    
//    MARK: Fields
    @IBOutlet weak var fieldLocation: UITextField!
    @IBOutlet weak var fieldUrl: UITextField!
    
//    MARK: Buttons
    @IBOutlet weak var buttonFindLocation: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
//    MARK: Image Views
    @IBOutlet weak var imageWorld: UIImageView! //This image is also used as activity indicator
    
//    MARK: Properties
    var latitude: Double?
    var longitude: Double?
    
//    MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableUI(true)
    }
    
//    MARK: Pressed Find Location
    @IBAction func pressedFindLocation(){
        enableUI(false)
        
//        GUARD: Verify location is not empty
        guard let stringLocation = fieldLocation.text, !stringLocation.isEmpty else{
            enableUI(true)
            ShowAlert.error(viewController: self, title: "Error", message: "Location field is Required!")
            return
        }
        
//        GUARD: Verify URL is not empty
        guard let stringUrl = fieldUrl.text, !stringUrl.isEmpty else{
            enableUI(true)
            ShowAlert.error(viewController: self, title: "Error", message: "Please provide a Website Address for your link.")
            return
        }
        
//        Make Search Request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = stringLocation
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard (error == nil) else {
                self.enableUI(true)
                ShowAlert.error(viewController: self, title: "Error", message: "Location Search Failed: \(error!.localizedDescription)")
                return
            }

//            Set Lat/Long from search request and segue to add location
            self.latitude = response?.boundingRegion.center.latitude
            self.longitude = response?.boundingRegion.center.longitude
            self.performSegue(withIdentifier: "segueAddLocation", sender: nil)
            self.enableUI(true)
        }
    }
    
//    MARK: Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddLocation" {
            let viewController = segue.destination as! AddStudentLocationViewController

            viewController.stringLocation = fieldLocation.text
            viewController.stringUrl = fieldUrl.text
            viewController.latitude = latitude
            viewController.longitude = longitude
        }
    }
    
//    MARK: Pressed Cancel
    @IBAction func pressedCancel(){
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: Pressed Return on Enter Location
    @IBAction func pressedReturnEnterLocation(_ sender: Any) {
        fieldUrl.becomeFirstResponder()
    }
    
//    MARK: Enable UI
    func enableUI(_ enable: Bool){
        fieldLocation.isEnabled = enable
        fieldUrl.isEnabled = enable
        RotateImage.rotate(!enable, imageWorld, hideWhenStopped: false)
    }
    
//    MARK: Hide Keyboard
//    Hides Keyboard when user touches outside of text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
