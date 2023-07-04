//
//  UILabel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/04.
//

import UIKit

extension UILabel {
    // Title
    static var title01: CGFloat = 30
    static var title02: CGFloat = 24
    
    // SubTitle
    static var subtitle01: CGFloat = 28
    
    // Body
    static var body01: CGFloat = 24
    static var body02: CGFloat = 21
    static var body03: CGFloat = 21
    
    // Caption
    static var caption01: CGFloat = 16
    static var caption02: CGFloat = 18
    static var caption03: CGFloat = 15
    
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
