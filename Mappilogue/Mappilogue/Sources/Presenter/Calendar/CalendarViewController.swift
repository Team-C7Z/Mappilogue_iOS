//
//  CalendarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class CalendarViewController: NavigationBarViewController {
    private let weekday: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var monthlyCalendar = MonthlyCalendar()
    private var days: [String] = []

    private let calendarHeaderView = UIView()
    private let currentDateLabel = UILabel()
    private let changeDateButton = UIButton()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: WeekdayCell.registerId)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addScheduleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        days = monthlyCalendar.getCurrentMonthlyCalendar()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        currentDateLabel.setTextWithLineHeight(text: "2023년 7월", lineHeight: UILabel.subtitle01)
        currentDateLabel.font = .subtitle01
        
        changeDateButton.setImage(UIImage(named: "changeDate"), for: .normal)
        
        addScheduleButton.setImage(UIImage(named: "addSchedule"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(calendarHeaderView)
        calendarHeaderView.addSubview(currentDateLabel)
        calendarHeaderView.addSubview(changeDateButton)
        
        view.addSubview(collectionView)
        view.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        calendarHeaderView.snp.makeConstraints {
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(118)
            $0.height.equalTo(28)
        }
        
        currentDateLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(calendarHeaderView)
        }
        
        changeDateButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(calendarHeaderView)
            $0.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(calendarHeaderView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-13)
            $0.width.height.equalTo(55)
        }
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return weekday.count
        default:
            return days.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCell.registerId, for: indexPath) as? WeekdayCell else { return UICollectionViewCell() }
            
            let weekday = weekday[indexPath.row]
            let isSaturday = indexPath.row % 7 == 6
            let isSunday = indexPath.row % 7 == 0
            
            cell.configure(with: weekday, isSaturday: isSaturday, isSunday: isSunday)
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.registerId, for: indexPath) as? DayCell else { return UICollectionViewCell() }
            
            let day = days[indexPath.row]
            if indexPath.row >= monthlyCalendar.lastMonthDays.count && indexPath.row < days.count - monthlyCalendar.nextMonthDays.count {
                let isSaturday = indexPath.row % 7 == 6
                let isSunday = indexPath.row % 7 == 0
                
                cell.configure(with: day, isNotCurrentMonth: false, isSaturday: isSaturday, isSunday: isSunday)
                
            } else {
                cell.configure(with: day, isNotCurrentMonth: true, isSaturday: false, isSunday: false)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 7
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 31)
        default:
            let height = (collectionView.bounds.height - 31) / CGFloat(days.count / 7)
            return CGSize(width: width, height: height)
        }
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
