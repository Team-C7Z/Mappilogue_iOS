//
//  UITextView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/10.
//

import UIKit

extension UITextView {
    func setLineAndLetterSpacing(_ text: String) {
        let style = NSMutableParagraphStyle()
   
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: text)

        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
    
        self.attributedText = attributedString
    }
}
