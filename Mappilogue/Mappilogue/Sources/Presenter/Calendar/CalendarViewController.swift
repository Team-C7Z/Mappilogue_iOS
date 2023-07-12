//
//  CalendarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

struct SelectedDate {
    var year: Int
    var month: Int
}

class CalendarViewController: NavigationBarViewController {    
    private var monthlyCalendar = MonthlyCalendar()
    private var selectedDate: SelectedDate?
    private var weekCount: Int = 0

    private var isDatePickerMode: Bool = false
    
    private let contentView = UIView()
    private let calendarHeaderView = UIView()
    private let currentDateLabel = UILabel()
    private let changeDateButton = UIButton()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: WeekdayCell.registerId)
        collectionView.register(WeekCell.self, forCellWithReuseIdentifier: WeekCell.registerId)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addScheduleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        selectedDate = SelectedDate(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        weekCount = monthlyCalendar.getThisMonthlyCalendarWeekCount()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .colorFFFFFF
        contentView.backgroundColor = .colorFFFFFF
        
        currentDateLabel.setTextWithLineHeight(text: "2023년 7월", lineHeight: UILabel.subtitle01)
        currentDateLabel.font = .subtitle01
        
        changeDateButton.setImage(UIImage(named: "changeDate"), for: .normal)
        changeDateButton.addTarget(self, action: #selector(changeDateButtonTapped), for: .touchUpInside)
        
        addScheduleButton.setImage(UIImage(named: "addSchedule"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(contentView)
        contentView.addSubview(calendarHeaderView)
        calendarHeaderView.addSubview(currentDateLabel)
        calendarHeaderView.addSubview(changeDateButton)
        
        contentView.addSubview(collectionView)
        contentView.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        calendarHeaderView.snp.makeConstraints {
            $0.centerX.top.equalTo(contentView)
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
            $0.leading.trailing.bottom.equalTo(contentView)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(-13)
            $0.width.height.equalTo(55)
        }
    }
    
    @objc func changeDateButtonTapped(_ sender: UIButton) {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.selectedDate = selectedDate
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        present(datePickerViewController, animated: false)
        
        isDatePickerMode = true
        chageDatePickerMode()
    }
    
    func chageDatePickerMode() {
        if isDatePickerMode {
            view.backgroundColor = .colorF5F3F0
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
            return monthlyCalendar.weekday.count
        default:
            return weekCount
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCell.registerId, for: indexPath) as? WeekdayCell else { return UICollectionViewCell() }
        
            let weekday = monthlyCalendar.weekday[indexPath.row]
            let isSaturday = monthlyCalendar.isSaturday(weekday)
            let isSunday = monthlyCalendar.isSunday(weekday)

            cell.configure(with: weekday, isSaturday: isSaturday, isSunday: isSunday)

            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCell.registerId, for: indexPath) as? WeekCell else { return UICollectionViewCell() }
            
            cell.configure(weekIndex: indexPath.row)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        
        switch indexPath.section {
        case 0:
            width = (collectionView.bounds.width - 32) / 7
            height = 31
        default:
            width = collectionView.bounds.width - 32
            let collectionViewHeight = collectionView.bounds.height - 31
            let cellHeight = CGFloat(weekCount)
            height = collectionViewHeight / cellHeight
        }
        return CGSize(width: width, height: height)
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
