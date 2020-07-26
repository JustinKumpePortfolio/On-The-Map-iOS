//
//  ShowAlert.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/19/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit

/* MARK: ShowAlert
 Class to hold reusable UIAlerts
*/
class ShowAlert {
    
//    Display alert with OK Button
    static func error(viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
    }
    
//    Display alert with YES and CANCEL buttons. YES button is destructive (red) and calls completion handler
    static func confirmDestructive(viewController: UIViewController, title: String, message: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (alert) in
            DispatchQueue.main.async {
                completion(true)
            }
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
