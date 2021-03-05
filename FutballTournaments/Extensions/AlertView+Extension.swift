//
//  File.swift
//  FutballTournaments
//
//  Created by bts on 04/03/21.
//

import Foundation
import UIKit

class AlertView: NSObject {

    class func showAlert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
