//
//  UIView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/01.
//

import Foundation
import UIKit

extension UIView {
  func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
