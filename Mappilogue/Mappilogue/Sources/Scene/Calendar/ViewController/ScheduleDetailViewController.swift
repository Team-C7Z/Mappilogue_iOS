//
//  ScheduleDetailViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleDetailViewController: BaseViewController {
    let calendarViewModel = CalendarViewModel()
    var date: String = ""
    var schedules = ScheduleDetailDTO(solarDate: "", lunarDate: "", schedulesOnSpecificDate: [])
    var selectedScheduleIndex: Int?
    var onWriteRecordButtonTapped: ((Schedule) -> Void)?
    var onAddScheduleButtonTapped: (() -> Void)?
    
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
    
        loadCalendarData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        animateAddScheduleButton()
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
    
    func loadCalendarData() {
        calendarViewModel.getScheduleDetail(date: date)
        
        calendarViewModel.$scheduleDetailResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let result else { return }
                self.schedules = result
                self.collectionView.reloadData()
                self.setDateLabel(date: self.schedules.solarDate, lunarDate: self.schedules.lunarDate)
            })
            .store(in: &calendarViewModel.cancellables)
    }

    func setDateLabel(date: String, lunarDate: String) {
        dateLabel.text = setDate(date: date)
        lunarDateLabel.text = setDate(date: lunarDate)
    }
    
    func setDate(date: String) -> String {
        let dateArr = date.split(separator: " ").map {String($0)}
        let (dateMonth, dateDay) = (dateArr[1], dateArr[2])
        
        return dateMonth + dateDay
    }
    
    func animateAddScheduleButton() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            let maxX = self.scheduleView.frame.maxX
            let maxY = self.scheduleView.frame.maxY
            self.addScheduleButton.frame.origin.x = maxX - 56 - 20
            self.addScheduleButton.frame.origin.y = maxY - 56 - 20
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onAddScheduleButtonTapped?()
        }
    }
    
    private func presentEditScheduleViewController() {
        let editViewController = EditViewController()
        editViewController.modalPresentationStyle = .overFullScreen
        editViewController.configure(modifyTitle: "기록 작성하기",
                                             deleteTitle: "일정 삭제하기",
                                             alert: Alert(titleText: "이 일정을 삭제할까요?",
                                                          messageText: nil,
                                                          cancelText: "취소",
                                                          doneText: "삭제",
                                                          buttonColor: .colorF14C4C,
                                                          alertHeight: 140))
        editViewController.onModify = { self.presentWriteRecordViewController() }
        editViewController.onDelete = { self.deleteSchedule() }
        present(editViewController, animated: false)
    }
    
    private func presentWriteRecordViewController() {
        dismiss(animated: false) {
            guard let index = self.selectedScheduleIndex else { return }
          //  self.onWriteRecordButtonTapped?(self.schedules[index])
        }
    }
    
    private func deleteSchedule() {
        guard let index = selectedScheduleIndex else { return }
      //  schedules.remove(at: index)
        collectionView.reloadData()
    }
}

extension ScheduleDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedules.schedulesOnSpecificDate.isEmpty ? 1 : schedules.schedulesOnSpecificDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if schedules.schedulesOnSpecificDate.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarEmptyScheduleCell.registerId, for: indexPath) as? CalendarEmptyScheduleCell else { return UICollectionViewCell() }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        
            cell.onEditButtonTapped = { index in
                self.selectedScheduleIndex = index
                self.presentEditScheduleViewController()
            }
            
            let schedule = schedules.schedulesOnSpecificDate[indexPath.row]
            cell.configure(selectedScheduleIndex ?? -1, schedule: schedule)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: schedules.schedulesOnSpecificDate.isEmpty ? collectionView.frame.height : 52)
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
