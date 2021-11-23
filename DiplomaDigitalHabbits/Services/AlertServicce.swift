//
//  File.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 23.11.2021.
//

import UIKit

class AlertService {
    class func presentErrorAlert (vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
