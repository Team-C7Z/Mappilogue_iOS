//
//  ContentView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class ContentView: BaseView {
    let textViewPlaceHolder = "내용을 입력하세요"
    var textViewHeight: CGFloat = 300
    var stackViewHeightUpdated: (() -> Void)?
    
    private let lineView = UIView()
    let contentView = UITextView()

    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        contentView.text = textViewPlaceHolder
        contentView.textColor = .colorC9C6C2
        contentView.font = .body01
        contentView.backgroundColor = .clear
        contentView.isScrollEnabled = false
        contentView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(lineView)
        addSubview(contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(textViewHeight)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-16)
        }
    }
}

extension ContentView: UITextViewDelegate {
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
        let fixedWidth = contentView.frame.size.width
        let newSize = contentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        self.snp.remakeConstraints {
            $0.height.equalTo(max(textViewHeight, newSize.height + 50))
        }
        stackViewHeightUpdated?()
        self.layoutIfNeeded()
    }
}

extension WriteRecordViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
