//
//  MapViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/26/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
//    MARK: Map Views
    @IBOutlet weak var viewMap: MKMapView!
    
//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap.delegate = self
        
//        Listense for data updates from TabView
        NotificationCenter.default.addObserver(self, selector: #selector(buildMap), name: .buildMap, object: nil)
    }
    
//    MARK: Build Annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = "pin"
        var pinAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView

        if pinAnnotation == nil {
            pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
            pinAnnotation!.canShowCallout = true

            if let url = URL(string: annotation.subtitle! ?? ""), url.host != nil {
                pinAnnotation!.rightCalloutAccessoryView = UIButton(type: .infoDark)
            }
        } else {
            pinAnnotation!.annotation = annotation
        }

        return pinAnnotation
    }

//    MARK: Did Select Annotation (Launches URL from Annotation Subtitle)
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            launchURL(view.annotation?.subtitle ?? "")
        }
    }
    
//    MARK: Build Map
    @objc func buildMap(){
        let pins = StudentInformation.studentLocationData
        var annotations = [MKPointAnnotation]()
        
//        Let's remove any existing annotations to start with a clean slate
        let existingAnnotations = viewMap.annotations
        if !existingAnnotations.isEmpty{
            viewMap.removeAnnotations(viewMap.annotations)
        }
        
//        For each pin build an annotation for pin and drop pin on map
        for pin in pins{
            if let lat = pin.latitude, let long = pin.longitude{
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotation.title = "\(pin.firstName ?? "") \(pin.lastName ?? "")"
                annotation.subtitle = pin.mediaURL
                annotations.append(annotation)
                
                viewMap.addAnnotations(annotations)
            }
        }
        
        viewMap.showAnnotations(viewMap.annotations, animated: true)
    }
}
