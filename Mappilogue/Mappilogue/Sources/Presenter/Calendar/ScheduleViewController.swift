//
//  ScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleViewController: BaseViewController {
    weak var dismissDelegate: DismissScheduleViewControllerDelegate?
    weak var presentDelegate: PresentAddScheduleViewControllerDelegate?
    
    private let scheduleView = UIView()
    private let dateLabel = UILabel()
    private let lunarDateLabel = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduleInfoCell.self, forCellWithReuseIdentifier: ScheduleInfoCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addScheduleButton = AddScheduleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color000000.withAlphaComponent(0.4)
        
        scheduleView.layer.cornerRadius = 24
        scheduleView.backgroundColor = .colorF9F8F7
        
        dateLabel.text = "5월 16일"
        dateLabel.font = .title01
        dateLabel.textColor = .color1C1C1C
        
        lunarDateLabel.text = "음력 3월 27일"
        lunarDateLabel.font = .body02
        lunarDateLabel.textColor = .color707070
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scheduleView)
        scheduleView.addSubview(dateLabel)
        scheduleView.addSubview(lunarDateLabel)
        scheduleView.addSubview(collectionView)
        scheduleView.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(429)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleView).offset(30)
            $0.leading.equalTo(scheduleView).offset(20)
        }
        
        lunarDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(6)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(scheduleView).offset(78)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.trailing.equalTo(scheduleView).offset(-20)
            $0.bottom.equalTo(scheduleView).offset(-21)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !scheduleView.frame.contains(touch.location(in: view)) else { return }
        
        dismiss(animated: false) {
            self.dismissDelegate?.dismissScheduleViewController()
        }
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.presentDelegate?.presentAddScheduleViewController()
        }
    }
}

extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleInfoCell.registerId, for: indexPath) as? ScheduleInfoCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-40, height: 52)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

protocol DismissScheduleViewControllerDelegate: AnyObject {
    func dismissScheduleViewController()
}

protocol PresentAddScheduleViewControllerDelegate: AnyObject {
    func presentAddScheduleViewController()
}
