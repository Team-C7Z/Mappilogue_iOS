//
//  UIButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/04.
//

import UIKit

extension UIButton {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - (titleLabel?.font.lineHeight ?? 0)) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            setAttributedTitle(attrString, for: .normal)
        }
    }
}
