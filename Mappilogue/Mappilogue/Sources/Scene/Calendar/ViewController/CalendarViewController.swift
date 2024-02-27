//
//  CalendarViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import MappilogueKit

class CalendarViewController: NavigationBarViewController {
    private var viewModel = CalendarViewModel()

    private let currentDateButton = UIButton()
    private let currentDateLabel = UILabel()
    private let changeDateImage = UIImageView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
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
    
        NotificationCenter.default.addObserver(self, selector: #selector(showCalendarDetailViewContoller), name: Notification.Name("PresentScheduleViewController"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissScheduleViewController), name: Notification.Name("DismissScheduleViewController"), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        setCurrentPage()
    }

    override func setupProperty() {
        super.setupProperty()
        
        setNotificationBar(title: "캘린더")

        setCalendarDate()
        
        currentDateButton.addTarget(self, action: #selector(changeDateButtonTapped), for: .touchUpInside)
        currentDateLabel.text = "\(viewModel.selectedDate.year)년 \(viewModel.selectedDate.month)월"
        currentDateLabel.font = .subtitle01
        changeDateImage.image = UIImage(named: "changeDate")
        
        addScheduleButton.addTarget(self, action: #selector(navigationToAddScheduleViewController), for: .touchUpInside)
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
            $0.top.equalToSuperview().offset(100)
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
        viewModel.loadCalendarData()
        viewModel.delegate = self
        viewModel.selectedDate = SelectedDate(year: viewModel.currentYear, month: viewModel.currentMonth)
    }
    
    func setCurrentPage() {
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    @objc func changeDateButtonTapped(_ sender: UIButton) {
        chageDatePickerMode()
        showDatePickerViewController()
    }
    
    func chageDatePickerMode() {
        view.backgroundColor = .grayF5F3F0
    }
    
    func showDatePickerViewController() {
        let viewController = DatePickerViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.viewModel.selectedDate = viewModel.selectedDate
        viewController.delegate = self
        present(viewController, animated: false)
    }
    
    @objc func showCalendarDetailViewContoller(_ notification: Notification) {
        addScheduleButton.isHidden = true
        if let date = notification.object as? String {
            showCalendarDetailViewController(date)
            //            scheduleDetailViewController.onWriteRecordButtonTapped = { schedule in
            //                self.navigationToWriteRecordViewController(schedule)
            //            }
        }
    }
    
    func showCalendarDetailViewController(_ date: String) {
        let viewController = CalendarDetailViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.delegate = self
        viewController.addButtonLocation = addScheduleButton.frame
        viewController.viewModel.date = date
        viewController.onAddScheduleButtonTapped = { id in
            self.viewModel.scheduleId = id
            self.showAddScheduleViewController(date: nil, id: id)
        }
        present(viewController, animated: false)
    }
    
    func navigationToWriteRecordViewController(_ schedule: Schedule2222) {
    //    coordinator?.showWriteRecordViewController(schedule: schedule)
    }
    
    @objc func dismissScheduleViewController(_ notification: Notification) {
        addScheduleButton.isHidden = false
        
        viewModel.loadCalendarData()
    }
    
    @objc func navigationToAddScheduleViewController() {
        addScheduleButton.isHidden = false
        
        showAddScheduleViewController(date: nil, id: nil)
    }
    
    func showAddScheduleViewController(date: String?, id: Int?) {
        let viewController = AddScheduleViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.viewModel.selectedDate = date
        viewController.viewModel.scheduleId = id
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.registerId, for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
        cell.configure(date: viewModel.selectedDate, dotDats: viewModel.dotDates)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        if viewModel.currentPage == 0 {
            viewModel.selectedDate = viewModel.changePreviousMonth(viewModel.selectedDate)
        } else if viewModel.currentPage == 2 {
            viewModel.selectedDate = viewModel.changeNextMonth(viewModel.selectedDate)
        }
        
        viewModel.currentPage = 1
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        currentDateLabel.text = "\(viewModel.selectedDate.year)년 \(viewModel.selectedDate.month)월"
        
        collectionView.reloadData()
    }
}

extension CalendarViewController: CalendarLoadDataDelegate {
    func reloadView() {
        collectionView.reloadData()
    }
}

extension CalendarViewController: DismissDatePickerViewControllerDelegate {
    func changedDate(_ date: SelectedDate) {
        view.backgroundColor = .grayF9F8F7
        viewModel.selectedDate = date
        updateCurrentDateLabel(year: date.year, month: date.month)
        viewModel.loadCalendarData()
        collectionView.reloadData()
    }
    
    private func updateCurrentDateLabel(year: Int, month: Int) {
        currentDateLabel.text = "\(year)년 \(month)월"
    }
}

extension CalendarViewController: CalendarDateDelegate {
    func selectDate(date: String) {
      //  showAddScheduleViewController(date: date, id: nil)
    }
}
