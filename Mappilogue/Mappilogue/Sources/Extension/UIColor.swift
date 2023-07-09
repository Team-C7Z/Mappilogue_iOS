//
//  UIColor.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/30.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // Gray Scale
    static let color1C1C1C = UIColor(hex: 0x1C1C1C) // Black
    static let color404040 = UIColor(hex: 0x404040) // Gray 6, Schedule Color
    static let color707070 = UIColor(hex: 0x707070) // Gray 5
    static let color9B9791 = UIColor(hex: 0x9B9791) // Gray 4
    static let colorC9C6C2 = UIColor(hex: 0xC9C6C2) // Gray 3, Schedule Color
    static let colorEAE6E1 = UIColor(hex: 0xEAE6E1) // Gray 2, Schedule Color
    static let colorF5F3F0 = UIColor(hex: 0xF5F3F0) // Gray 1.5
    static let colorF9F8F7 = UIColor(hex: 0xF9F8F7) // Gray 1
    static let colorFFFFFF = UIColor(hex: 0xFFFFFF) // White
    
    // Primary
    static let color2EBD3D = UIColor(hex: 0x2EBD3D) // Green 1
    static let color379240 = UIColor(hex: 0x379240) // Green 2
    static let color43B54E = UIColor(hex: 0x43B54E) // Green 3
    
    // Secondary
    static let colorF14C4C = UIColor(hex: 0xF14C4C) // Red 1
    
    // Schedule Colors
    static let colorFFA1A1 = UIColor(hex: 0xFFA1A1)
    static let colorFFAF82 = UIColor(hex: 0xFFAF82)
    static let colorF5DC82 = UIColor(hex: 0xF5DC82)
    static let colorF0F1B0 = UIColor(hex: 0xF0F1B0)
    static let colorCAEDA8 = UIColor(hex: 0xCAEDA8)
    static let colorB1E9BE = UIColor(hex: 0xB1E9BE)
    static let colorB2EAD6 = UIColor(hex: 0xB2EAD6)
    static let colorB2EBE7 = UIColor(hex: 0xB2EBE7)
    static let colorABD9F3 = UIColor(hex: 0xABD9F3)
    static let colorBAD7FA = UIColor(hex: 0xBAD7FA)
    static let colorE6C3F2 = UIColor(hex: 0xE6C3F2)
    static let colorF0B4D5 = UIColor(hex: 0xF0B4D5)
    
    static let color3C58EE = UIColor(hex: 0x3C58EE)
}
