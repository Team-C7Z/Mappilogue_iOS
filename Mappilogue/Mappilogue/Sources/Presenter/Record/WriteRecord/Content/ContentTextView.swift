//
//  ContentTextView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class ContentTextView: BaseView {
    let textViewPlaceHolder = "기록을 입력하세요"
    var textViewHeight: CGFloat = 300
    var stackViewHeightUpdated: (() -> Void)?
    
    let textView = UITextView()

    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
       
        textView.text = textViewPlaceHolder
        textView.textColor = .color9B9791
        textView.backgroundColor = .clear
        textView.font = .body02
        textView.tintColor = .color2EBD3D
        textView.isScrollEnabled = false
        textView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(textView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(textViewHeight)
        }
        
        textView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(self).offset(12)
            $0.bottom.equalTo(self).offset(-100)
        }
    }
}

extension ContentTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .color1C1C1C
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .color9B9791
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.setLineAndLetterSpacing(textView.text)
        textView.font = .body02
        textView.textColor = .color1C1C1C
        updateTextViewHeight()
    }
    
    func updateTextViewHeight() {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        self.snp.remakeConstraints {
            $0.height.equalTo(max(textViewHeight, newSize.height + 130))
        }
        stackViewHeightUpdated?()
        self.layoutIfNeeded()
    }
}
