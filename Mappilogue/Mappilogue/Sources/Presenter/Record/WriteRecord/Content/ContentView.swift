//
//  ContentView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit
import Photos

class ContentView: BaseView {
    let textViewPlaceHolder = "내용을 입력하세요"
    var textViewHeight: CGFloat = 400
    var stackViewHeightUpdated: (() -> Void)?
    
    let contentView = UITextView()

    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
       
        contentView.text = textViewPlaceHolder
        contentView.textColor = .colorC9C6C2
        contentView.font = .body01
        contentView.backgroundColor = .clear
        contentView.isScrollEnabled = false
        contentView.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(textViewHeight)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-50)
        }
    }
    
    func displaySelectedImages(assets: [PHAsset]) {
        if contentView.text == textViewPlaceHolder {
            contentView.text = nil
            contentView.textColor = .color1C1C1C
        }

        let attributedText = NSMutableAttributedString(attributedString: contentView.attributedText)
        for asset in assets {
            let imageAttachment = NSTextAttachment()
            convertPHAssetToUIImage(asset) { image in
                imageAttachment.image = image
            }
           
        }
    }
    
    private func convertPHAssetToUIImage(_ asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        let imageManager = PHImageManager.default()
        let options = PHImageRequestOptions()
        
        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, _ in
            completion(image)
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
            $0.height.equalTo(max(textViewHeight, newSize.height + 100))
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
