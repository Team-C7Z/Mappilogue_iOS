//
//  TextContentView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class TextContentView: BaseView {
    var isFirst: Bool = false
    let textViewPlaceHolder = "내용을 입력하세요"
    var textViewHeight: CGFloat = 50
    var stackViewHeightUpdated: (() -> Void)?
    
    let contentView = UITextView()

    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
       
        contentView.backgroundColor = .clear
        contentView.font = .body01
        contentView.isScrollEnabled = false
        contentView.delegate = self
        contentView.setLineAndLetterSpacing(contentView.text)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(self)
            $0.bottom.equalTo(self)
        }
    }
    
    func configure(_ isFirst: Bool) {
        self.isFirst = isFirst
        if isFirst {
            contentView.text = textViewPlaceHolder
            contentView.textColor = .colorC9C6C2
         
            contentView.snp.updateConstraints {
                $0.top.equalTo(self).offset(16)
            }
        } else {
            if contentView.text == textViewPlaceHolder {
                contentView.text = ""
            }
            
            contentView.textColor = .color1C1C1C
        }
    }
}

extension TextContentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .color1C1C1C
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if isFirst && textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .colorC9C6C2
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        contentView.setLineAndLetterSpacing(textView.text)
        contentView.font = .body01
        updateTextViewHeight()
    }
    
    func updateTextViewHeight() {
        let fixedWidth = contentView.frame.size.width
        let newSize = contentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        self.snp.remakeConstraints {
            $0.height.equalTo(max(textViewHeight, isFirst ? newSize.height+32 : newSize.height+16))
        }
        stackViewHeightUpdated?()
        self.layoutIfNeeded()
    }
}

extension UITextView {
    func setLineAndLetterSpacing(_ text: String) {
        let style = NSMutableParagraphStyle()
   
        style.lineSpacing = 5
        let attributedString = NSMutableAttributedString(string: text)

        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
