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
    var day: Int?
}

class CalendarViewController: NavigationBarViewController {
    private var monthlyCalendar = MonthlyCalendar()
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0)
    
    private let currentDateButton = UIButton()
    private let currentDateLabel = UILabel()
    private let changeDateImage = UIImageView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addScheduleButton = AddScheduleButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        setCalendarDate()
        
        view.backgroundColor = .colorFFFFFF
        
        currentDateButton.addTarget(self, action: #selector(changeDateButtonTapped), for: .touchUpInside)
        currentDateLabel.text = "\(selectedDate.year)년 \(selectedDate.month)월"
        currentDateLabel.font = .subtitle01
        changeDateImage.image = UIImage(named: "checkDate")
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(currentDateButton)
        currentDateButton.addSubview(currentDateLabel)
        currentDateButton.addSubview(changeDateImage)
        
        view.addSubview(collectionView)
        view.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        currentDateButton.snp.makeConstraints {
            $0.centerX.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(118)
            $0.height.equalTo(28)
        }
        
        currentDateLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(currentDateButton)
        }
        
        changeDateImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(currentDateButton)
            $0.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentDateButton.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-13)
        }
    }
    
    func setCalendarDate() {
        selectedDate = SelectedDate(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
    }
    
    @objc func changeDateButtonTapped(_ sender: UIButton) {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.selectedDate = selectedDate
        datePickerViewController.delegate = self
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        present(datePickerViewController, animated: false)
        
        chageDatePickerMode()
    }
    
    func chageDatePickerMode() {
        view.backgroundColor = .colorF5F3F0
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        let addScheduleViewController = AddScheduleViewController()
        navigationController?.pushViewController(addScheduleViewController, animated: false)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.registerId, for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        cell.configure(with: selectedDate)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}

extension CalendarViewController: ChangedDateDelegate, DismissScheduleViewControllerDelegate, PresentAddScheduleViewControllerDelegate {
    func chagedDate(_ selectedDate: SelectedDate) {
        view.backgroundColor = .colorFFFFFF
        
        self.selectedDate = selectedDate
        
        let year = selectedDate.year
        let month = selectedDate.month
        currentDateLabel.text = "\(year)년 \(month)월"
        
        collectionView.reloadData()
    }
    
    func dismissScheduleViewController() {
        addScheduleButton.isHidden = false
    }
    
    func presentAddScheduleViewController() {
        let addScheduleViewController = AddScheduleViewController()
        navigationController?.pushViewController(addScheduleViewController, animated: false)
    }
}
