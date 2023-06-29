//
//  UIFont.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

extension UIFont {
    public enum PretendardType : String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    ///폰트 적용 함수
    static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size)!
    }
}
