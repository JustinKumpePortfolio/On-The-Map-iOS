//
//  CustomActivityIndicator.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/25/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//
// This class was copied in part from https://stackoverflow.com/questions/49666907/custom-image-with-rotation-in-activity-indicator-for-iphone-application-in-swift
// Written By Nazar Lisovyi

import Foundation
import UIKit

class RotateImage {


    static func start(_ imageView: UIImageView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }

    static func stop(_ imageView: UIImageView) {
         imageView.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    static func rotate(_ rotate: Bool, _ imageView: UIImageView){
        if rotate{
            start(imageView)
        }else{
            stop(imageView)
        }
    }
}
