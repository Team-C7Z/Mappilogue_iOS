//
//  DayCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/07.
//

import UIKit

class DayCell: BaseCollectionViewCell {
    static let registerId = "\(DayCell.self)"
    
    private var day: String = ""
    private var schedules: [Schedule] = []
    
    private let todayView = UIView()
    private let dayLabel = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        todayView.layer.cornerRadius = 21 / 2
        
        dayLabel.setTextWithLineHeight(text: "", lineHeight: UILabel.body02)
        dayLabel.font = .body02
        
        lineView.backgroundColor = .colorEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        todayView.addSubview(dayLabel)
        contentView.addSubview(todayView)
        contentView.addSubview(collectionView)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.centerX.equalTo(contentView)
            $0.width.height.equalTo(21)
        }
        
        dayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(todayView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(31)
            $0.leading.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView).offset(-4)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with day: String, schedules: [Schedule], isCurrentMonth: Bool, isSaturday: Bool, isSunday: Bool, isToday: Bool) {
        dayLabel.setTextWithLineHeight(text: day, lineHeight: UILabel.body02)
        self.schedules = schedules
        
        if isCurrentMonth {
            dayLabel.textColor = .color1C1C1C
            
            if isToday {
                todayView.backgroundColor = .color2EBD3D
                dayLabel.textColor = .colorFFFFFF
            } else if isSaturday {
                dayLabel.textColor = .color3C58EE
            } else if isSunday {
                dayLabel.textColor = .colorF14C4C
            }
        } else {
            dayLabel.textColor = .color9B9791
        }
    }
}

extension DayCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(schedules.count, 3)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        
        let schedule = schedules[indexPath.row]
        let scheduleTitle = schedule.schedule
        let color = schedule.color

        cell.configure(with: scheduleTitle, color: color)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 16)
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
