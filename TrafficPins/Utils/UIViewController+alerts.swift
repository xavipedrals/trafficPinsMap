//
//  UIViewController+alerts.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addCancelAction() {
        self.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
    }
    
    func addDefaultAction(_ title: String, handler: ((UIAlertAction) -> Void)? = nil) {
        self.addAction(UIAlertAction(title: title, style: .default, handler: handler))
    }
}

extension UIViewController {
    func display(error: Error, completion: (() -> ())? = nil) {
        displayAlert(title: "Error", message: error.localizedDescription)
    }
    
    func displayError(message: String) {
        displayAlert(title: "error", message: message)
    }
    
    func displayTwoOptions(title: String, message: String, okOption: String, completion: @escaping (UIAlertAction) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okOption, style: .default, handler: completion))
        alert.addCancelAction()
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlert(title: String, message: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
