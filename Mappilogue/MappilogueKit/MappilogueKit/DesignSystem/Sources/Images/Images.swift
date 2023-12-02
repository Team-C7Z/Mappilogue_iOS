//
//  Images.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class Images {
    static let bundle = Bundle(for: Images.self)
}

public extension Images {
    enum images{ }
}

public extension Images.images {
    static var toastGathering: UIImage { .load(name: "toast_gathering") }
    static var toastGatheringArrow: UIImage { .load(name: "toast_gathering_arrow") }
    static var toastDelete: UIImage { .load(name: "toast_delete") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: Images.bundle, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        return image
    }
}
