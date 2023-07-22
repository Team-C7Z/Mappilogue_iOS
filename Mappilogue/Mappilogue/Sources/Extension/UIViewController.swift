//
//  UIViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround(_ tapView: AnyObject) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tapView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
