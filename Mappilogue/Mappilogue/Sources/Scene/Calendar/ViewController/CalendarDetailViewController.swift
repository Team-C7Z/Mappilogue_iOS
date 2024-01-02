//
//  CalendarDetailViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit
import MappilogueKit

class CalendarDetailViewController: ModalViewController {
    weak var coordinator: CalendarDetailCoordinator?
    let viewModel = CalendarDetailViewModel()
 
    var onWriteRecordButtonTapped: ((Schedule) -> Void)?
    var onAddScheduleButtonTapped: ((Int?) -> Void)?
    
    var addButtonLocation: CGRect?
    
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
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        animateAddScheduleButton()
    }
    
    func setupProperty() {
        dateLabel.font = .title01
        dateLabel.textColor = .black1C1C1C
        
        lunarDateLabel.font = .body02
        lunarDateLabel.textColor = .gray707070
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        modalView.addSubview(dateLabel)
        modalView.addSubview(lunarDateLabel)
        modalView.addSubview(collectionView)
        view.addSubview(addScheduleButton)
    }
    
    func setupLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(30)
            $0.leading.equalTo(modalView).offset(20)
        }
        
        lunarDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(6)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(78)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(modalView).offset(-18)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.leading.equalTo(view).offset(addButtonLocation?.minX ?? 0)
            $0.top.equalTo(view).offset(addButtonLocation?.minY ?? 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !modalView.frame.contains(touch.location(in: view)) else { return }
        
        view.backgroundColor = .clear
        modalView.isHidden = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.addScheduleButton.frame.origin.x = self.addButtonLocation?.minX ?? 0
            self.addScheduleButton.frame.origin.y = self.addButtonLocation?.minY ?? 0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            NotificationCenter.default.post(name: Notification.Name("DismissScheduleViewController"), object: nil)
            self.coordinator?.dismissViewController()
        })
    }
    
    func loadCalendarData() {
        viewModel.getScheduleDetail(date: viewModel.date)
        
        viewModel.$scheduleDetailResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let result else { return }
                self.viewModel.schedules = result
                self.collectionView.reloadData()
                self.setDateLabel(date: self.viewModel.schedules.solarDate, lunarDate: self.viewModel.schedules.lunarDate)
            })
            .store(in: &viewModel.cancellables)
    }

    func setDateLabel(date: String, lunarDate: String) {
        dateLabel.text = viewModel.setDate(date: date)
        lunarDateLabel.text = viewModel.setDate(date: lunarDate)
    }
    
    func animateAddScheduleButton() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            let maxX = self.modalView.frame.maxX
            let maxY = self.modalView.frame.maxY
            self.addScheduleButton.frame.origin.x = maxX - 56 - 20
            self.addScheduleButton.frame.origin.y = maxY - 56 - 20
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        onAddScheduleButtonTapped?(nil)
        coordinator?.dismissViewController()
    }
    
    private func presentEditScheduleViewController() {
//        let editViewController = EditBottomSheetViewController()
//        editViewController.modalPresentationStyle = .overFullScreen
//        editViewController.configure(modifyTitle: "기록 작성하기",
//                                             deleteTitle: "일정 삭제하기",
//                                             alert: Alert(titleText: "이 일정을 삭제할까요?",
//                                                          messageText: nil,
//                                                          cancelText: "취소",
//                                                          doneText: "삭제",
//                                                          buttonColor: .redF14C4C,
//                                                          alertHeight: 140))
//        editViewController.onModify = { self.showWriteRecordViewController() }
//        editViewController.onDelete = { self.deleteSchedule() }
        coordinator?.showEditScheduleViewController()
    }
    
    private func showWriteRecordViewController() {
        guard let index = self.viewModel.selectedScheduleIndex else { return }
        //  self.onWriteRecordButtonTapped?(self.schedules[index])
        coordinator?.dismissViewController()
    }
    
    private func deleteSchedule() {
        viewModel.deleteSchedule(id: self.viewModel.selectedScheduleIndex ?? -1, date: viewModel.date)
    }
}

extension CalendarDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.schedules.schedulesOnSpecificDate.isEmpty ? 1 : viewModel.schedules.schedulesOnSpecificDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.schedules.schedulesOnSpecificDate.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarEmptyScheduleCell.registerId, for: indexPath) as? CalendarEmptyScheduleCell else { return UICollectionViewCell() }
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        
            let schedule = viewModel.schedules.schedulesOnSpecificDate[indexPath.row]
            cell.configure(schedule.scheduleId, schedule: schedule)
            
            cell.onEditButtonTapped = { index in
                self.viewModel.selectedScheduleIndex = index
                self.presentEditScheduleViewController()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: viewModel.schedules.schedulesOnSpecificDate.isEmpty ? collectionView.frame.height : 52)
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
        let id = viewModel.schedules.schedulesOnSpecificDate[indexPath.row].scheduleId
        onAddScheduleButtonTapped?(id)
        coordinator?.dismissViewController()
    }
}
