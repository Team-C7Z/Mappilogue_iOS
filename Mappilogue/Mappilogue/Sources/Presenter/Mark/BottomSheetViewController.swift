//
//  BottomSheetViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class BottomSheetViewController: BaseViewController {
    private let barImage = UIImageView()
    let stackView = UIStackView()
    private let emptyMarkLabel = UILabel()
    private let emptyMarkSubLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .colorF9F8F7
        
        barImage.image = UIImage(named: "bottomSheetBar")
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyMarkLabel.text = "표시할 기록이 없어요"
        emptyMarkLabel.textColor = .color707070
        emptyMarkLabel.font = .title02
        
        emptyMarkSubLabel.text = "캘린더에 등록했던 일정에서 기록을 만들어 보세요"
        emptyMarkSubLabel.textColor = .color707070
        emptyMarkSubLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(barImage)
        view.addSubview(stackView)
        stackView.addArrangedSubview(emptyMarkLabel)
        stackView.addArrangedSubview(emptyMarkSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barImage.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view).offset(12)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(80)
            $0.centerX.equalTo(view)
        }
    }
}
