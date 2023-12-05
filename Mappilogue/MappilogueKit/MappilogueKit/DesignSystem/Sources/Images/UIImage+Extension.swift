//
//  UIImage+Extension.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: Images.bundle, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        return image
    }
}
