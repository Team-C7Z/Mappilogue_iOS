//
//  EditBottomSheetViewController.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class EditBottomSheetViewController: UIViewController {
    var alert: Alert?
    public var onModify: (() -> Void)?
    public var onDelete: (() -> Void)?
    
    private let modalView = UIView()
    private let barView = UIView()
    private let modifyButton = UIButton()
    private let modifyImage = UIImageView()
    private let modifyLabel = UILabel()
    private let deleteButton = UIButton()
    private let deleteImage = UIImageView()
    private let deleteLabel = UILabel()

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
   func setupProperty() {
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        modalView.layer.cornerRadius = 24
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        modalView.layer.masksToBounds = true
        modalView.backgroundColor = .grayF9F8F7
        
        barView.backgroundColor = .grayC9C6C2
        
        modifyImage.image = Images.image(named: .imageModify)
        modifyLabel.textColor = .black1C1C1C
        modifyLabel.font = .title02
        modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
        
       deleteImage.image = Images.image(named: .imageDelete)
        deleteImage.tintColor = .redF14C4C
        deleteLabel.textColor = .black1C1C1C
        deleteLabel.font = .title02
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        view.addSubview(modalView)
        modalView.addSubview(barView)
        modalView.addSubview(modifyButton)
        modifyButton.addSubview(modifyImage)
        modifyButton.addSubview(modifyLabel)
        modalView.addSubview(deleteButton)
        deleteButton.addSubview(deleteImage)
        deleteButton.addSubview(deleteLabel)
    }
    
    func setupLayout() {
        modalView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view)
            $0.height.equalTo(216)
        }
        
        barView.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(12)
            $0.centerX.equalTo(modalView)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(42)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(16)
            $0.height.equalTo(56)
        }
        
        modifyImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(modifyButton)
            $0.width.equalTo(18)
            $0.height.equalTo(17)
        }
        
        modifyLabel.snp.makeConstraints {
            $0.leading.equalTo(modifyImage.snp.trailing).offset(16)
            $0.centerY.equalTo(modifyButton)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(-16)
            $0.height.equalTo(56)
        }
        
        deleteImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(deleteButton)
            $0.width.equalTo(18)
            $0.height.equalTo(20)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteImage.snp.trailing).offset(15)
            $0.centerY.equalTo(deleteButton)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y < modalView.frame.maxY else {
            return
        }
        dismiss(animated: false)
    }
    
    public func configure(modifyTitle: String, deleteTitle: String, alert: Alert) {
        modifyLabel.text = modifyTitle
        deleteLabel.text = deleteTitle
        self.alert = alert
    }
    
    @objc func modifyButtonTapped(_ button: UIButton) {
        self.dismiss(animated: false) {
            self.onModify?()
        }
    }
    
    @objc func deleteButtonTapped(_ button: UIButton) {
        guard let alert = alert else { return }
        
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            self.dismiss(animated: false) {
                self.onDelete?()
           }
        }
        present(alertViewController, animated: false)
    }
}
