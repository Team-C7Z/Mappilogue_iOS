//
//  UITextField+Extension.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

extension UITextField {
    public func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        tintColor = .green2EBD3D
    }
}
