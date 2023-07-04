//
//  UIFont.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

extension UIFont {
    public enum PretendardType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    
    // Title
    static var title01: UIFont { pretendard(.medium, size: 20) }
    static var title02: UIFont { pretendard(.medium, size: 16) }
    
    // SubTitle
    static var subtitle01: UIFont { pretendard(.medium, size: 18) }
    
    // Body
    static var body01: UIFont { pretendard(.regular, size: 16) }
    static var body02: UIFont { pretendard(.regular, size: 14) }
    static var body03: UIFont { pretendard(.semiBold, size: 14) }
    
    // Caption
    static var caption01: UIFont { pretendard(.regular, size: 12) }
    static var caption02: UIFont { pretendard(.medium, size: 12) }
    static var caption03: UIFont { pretendard(.medium, size: 10) }
    
    // 폰트 적용 함수
    private static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size)!
    }
}
