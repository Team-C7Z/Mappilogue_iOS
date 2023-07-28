//
//  TextContentCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class TextContentView: BaseView {
    weak var delegate: ContentTextViewHeightDelegate?
    
    let textViewPlaceHolder = "내용을 입력하세요"
    
    private let lineView = UIView()
    let contentTextView = UITextView()

    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        contentTextView.text = textViewPlaceHolder
        contentTextView.textColor = .colorC9C6C2
        contentTextView.font = .body01
        contentTextView.backgroundColor = .gray
        contentTextView.returnKeyType = .done
        contentTextView.isScrollEnabled = false
        contentTextView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(lineView)
        addSubview(contentTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-16)
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
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .colorC9C6C2
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateTextViewHeight()
    }
    
    func updateTextViewHeight() {
        let fixedWidth = contentTextView.frame.size.width
        let newSize = contentTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        contentTextView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        delegate?.updateContentTextViewHeight(newSize.height)
    }
}

protocol ContentTextViewHeightDelegate: AnyObject {
    func updateContentTextViewHeight(_ height: CGFloat)
}
