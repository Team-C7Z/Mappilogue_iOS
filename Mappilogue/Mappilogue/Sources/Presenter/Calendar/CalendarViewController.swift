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
    
    private var currentPage = 1
    
    private let currentDateButton = UIButton()
    private let currentDateLabel = UILabel()
    private let changeDateImage = UIImageView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var addScheduleButton = AddScheduleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(presentScheduleViewContoller), name: Notification.Name("PresentScheduleViewController"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissScheduleViewController), name: Notification.Name("DismissScheduleViewController"), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        setCurrentPage()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setCalendarDate()
        
        currentDateButton.addTarget(self, action: #selector(changeDateButtonTapped), for: .touchUpInside)
        currentDateLabel.text = "\(selectedDate.year)년 \(selectedDate.month)월"
        currentDateLabel.font = .subtitle01
        changeDateImage.image = UIImage(named: "changeDate")
        
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
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(currentDateLabel.snp.leading)
            $0.trailing.equalTo(changeDateImage.snp.trailing)
            $0.height.equalTo(28)
        }
      
        currentDateLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(currentDateButton)
        }
        
        changeDateImage.snp.makeConstraints {
            $0.leading.equalTo(currentDateLabel.snp.trailing).offset(3)
            $0.centerY.equalTo(currentDateButton)
            $0.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentDateButton.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    func setCalendarDate() {
        selectedDate = SelectedDate(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
    }
    
    func setCurrentPage() {
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
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
        navigationController?.pushViewController(addScheduleViewController, animated: true)
    }
    
    @objc func presentScheduleViewContoller(_ notification: Notification) {
        addScheduleButton.isHidden = true
        if let calendarSchedule = notification.object as? CalendarSchedule {
            let scheduleViewController = ScheduleViewController()
            scheduleViewController.calendarSchedule = calendarSchedule
            scheduleViewController.addButtonLocation = addScheduleButton.frame
            scheduleViewController.modalPresentationStyle = .overFullScreen
            present(scheduleViewController, animated: false)
        }
    }
    
    @objc func dismissScheduleViewController(_ notification: Notification) {
        addScheduleButton.isHidden = false
    }
    
    func presentAddScheduleViewController() {
        let addScheduleViewController = AddScheduleViewController()
        navigationController?.pushViewController(addScheduleViewController, animated: true)
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
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        if currentPage == 0 {
            selectedDate = changePreviousMonth(selectedDate)
        } else if currentPage == 2 {
            selectedDate = changeNextMonth(selectedDate)
        }
        
        currentPage = 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        currentDateLabel.text = "\(selectedDate.year)년 \(selectedDate.month)월"
        
        collectionView.reloadData()
    }
    
    private func changePreviousMonth(_ date: SelectedDate) -> SelectedDate {
        var newDate = date
        if date.month == 1 {
            newDate.year -= 1
            newDate.month = 12
        } else {
            newDate.month -= 1
        }
        return newDate
    }
    
    private func changeNextMonth(_ date: SelectedDate) -> SelectedDate {
        var newDate = date
        if date.month == 12 {
            newDate.year += 1
            newDate.month = 1
        } else {
            newDate.month += 1
        }
        return newDate
    }
}

extension CalendarViewController: ChangedDateDelegate {
    func chagedDate(_ selectedDate: SelectedDate) {
        view.backgroundColor = .colorF9F8F7
        self.selectedDate = selectedDate
        updateCurrentDateLabel()

        collectionView.reloadData()
    }
    
    private func updateCurrentDateLabel() {
        let year = selectedDate.year
        let month = selectedDate.month
        currentDateLabel.text = "\(year)년 \(month)월"
    }
}
