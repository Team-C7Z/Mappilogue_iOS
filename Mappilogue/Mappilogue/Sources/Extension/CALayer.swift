//
//  CALayer.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import Foundation
import UIKit

extension CALayer {
    func applyShadow() {
        shadowColor = UIColor.color000000.cgColor
        shadowOpacity = 0.1
        shadowRadius = 4.0
        shadowOffset = CGSize(width: 0, height: 2)
        masksToBounds = false
    }
    
    func applyMainColorShadow() {
        shadowColor = UIColor.color379240.cgColor
        shadowOpacity = 0.14
        shadowRadius = 4.0
        shadowOffset = CGSize(width: 0, height: 4)
        masksToBounds = false
    }
}
