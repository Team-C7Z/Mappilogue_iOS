//
//  ScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleViewController: BaseViewController {
    var calendarSchedule: CalendarSchedule?
    let lunarDate: String = ""
    var schedules = [Schedule]()
    
    var addButtonLocation: CGRect?
    
    private let scheduleView = UIView()
    private let dateLabel = UILabel()
    private let lunarDateLabel = UILabel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CalendarEmptyScheduleCell.self, forCellWithReuseIdentifier: CalendarEmptyScheduleCell.registerId)
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addScheduleButton = AddScheduleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let month = calendarSchedule?.month, let day = calendarSchedule?.day {
            dateLabel.text = "\(month)월 \(day)일"
        }
        schedules = calendarSchedule?.schedules ?? []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.addScheduleButton.frame.origin.x = self.scheduleView.frame.maxX - 56 - 20
            self.addScheduleButton.frame.origin.y = self.scheduleView.frame.maxY - 56 - 20
            self.view.layoutIfNeeded()
        })
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        scheduleView.layer.cornerRadius = 24
        scheduleView.backgroundColor = .colorF9F8F7
        
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
        view.addSubview(addScheduleButton)
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(scheduleView).offset(-18)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.leading.equalTo(view).offset(addButtonLocation?.minX ?? 0)
            $0.top.equalTo(view).offset(addButtonLocation?.minY ?? 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !scheduleView.frame.contains(touch.location(in: view)) else { return }
        
        view.backgroundColor = .clear
        scheduleView.isHidden = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.addScheduleButton.frame.origin.x = self.addButtonLocation?.minX ?? 0
            self.addScheduleButton.frame.origin.y = self.addButtonLocation?.minY ?? 0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false) {
                NotificationCenter.default.post(name: Notification.Name("DismissScheduleViewController"), object: nil)
            }
        })
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            //
        }
    }
}

extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedules.isEmpty ? 1 : schedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if schedules.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarEmptyScheduleCell.registerId, for: indexPath) as? CalendarEmptyScheduleCell else { return UICollectionViewCell() }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
            if let schedules = calendarSchedule?.schedules, schedules.count > indexPath.row {
                let schedule = schedules[indexPath.row]
                cell.configure(with: schedule)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: schedules.isEmpty ? collectionView.frame.height : 52)
    }
  
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
