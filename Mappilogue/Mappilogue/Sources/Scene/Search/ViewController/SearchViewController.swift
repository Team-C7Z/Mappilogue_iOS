//
//  SearchViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit
import MappilogueKit

class SearchViewController: NavigationBarViewController {
    weak var coordinator: SearchCoordinator?
    var viewModel = SearchViewModel()

    var keyboardHeight: CGFloat = 0
    
    private let searchBar = SearchBar()
    private let stackView = UIStackView()
    private var locationButton = UIButton()
    private var recordButton = UIButton()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(EmptySearchCell.self, forCellWithReuseIdentifier: EmptySearchCell.registerId)
        collectionView.register(SearchLocationCell.self, forCellWithReuseIdentifier: SearchLocationCell.registerId)
        collectionView.register(SearchRecordCell.self, forCellWithReuseIdentifier: SearchRecordCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardObservers()
        hideKeyboardWhenTappedAround()
        setSearchButtonDesign()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "검색")
        popBar.onPopButtonTapped = {
            self.coordinator?.popViewController()
        }
        
        searchBar.configure("장소 또는 기록 검색")
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        locationButton = createCategoryButton("장소")
        recordButton = createCategoryButton("기록")
        setSearchButtonDesign()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
       
        view.addSubview(searchBar)
        view.addSubview(stackView)
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(recordButton)
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(12)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: false)
    }

    private func keyboardWillChange(_ notification: Notification, isShowing: Bool) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        keyboardHeight = isShowing ? keyboardFrame.cgRectValue.height + 16 : 42
        collectionView.reloadData()
    }
    
    private func createCategoryButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .body03
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    @objc func categoryButtonTapped(_ button: UIButton) {
        switch button {
        case locationButton:
            viewModel.searchType = .location
        case recordButton:
            viewModel.searchType = .record
        default:
            break
        }
        setSearchButtonDesign()
        collectionView.reloadData()
    }
    
    private func setSearchButtonDesign() {
        setLocationButtonDesign()
        setRecordButtonDesign()
    }
    
    private func setLocationButtonDesign() {
        locationButton.setTitleColor(viewModel.searchType == .location ? .whiteFFFFFF : .gray707070, for: .normal)
        locationButton.backgroundColor = viewModel.searchType == .location ? .green2EBD3D : .grayF5F3F0
    }
    
    private func setRecordButtonDesign() {
        recordButton.setTitleColor(viewModel.searchType == .record ? .whiteFFFFFF : .gray707070, for: .normal)
        recordButton.backgroundColor = viewModel.searchType == .record ? .green2EBD3D : .grayF5F3F0
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.searchType {
        case .location:
            return viewModel.dummyLocation.isEmpty ? 1 : viewModel.dummyLocation.count
        case .record:
            return viewModel.dummyRecord.isEmpty ? 1 : viewModel.dummyRecord.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.searchType {
        case .location:
            if viewModel.dummyLocation.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptySearchCell.registerId, for: indexPath) as? EmptySearchCell else { return UICollectionViewCell() }
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchLocationCell.registerId, for: indexPath) as? SearchLocationCell else { return UICollectionViewCell() }
         
                let location = viewModel.dummyLocation[indexPath.row]
                cell.configure(with: location)
                
                return cell
            }
        case .record:
            if viewModel.dummyRecord.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptySearchCell.registerId, for: indexPath) as? EmptySearchCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchRecordCell.registerId, for: indexPath) as? SearchRecordCell else { return UICollectionViewCell() }
                
                let record = viewModel.dummyRecord[indexPath.row]
                cell.configure(with: record)
                    
                return cell
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.searchType {
        case .location:
            return CGSize(width: collectionView.frame.width - 32, height: viewModel.dummyLocation.isEmpty ? collectionView.frame.height - keyboardHeight : 44)
        case .record:
            return CGSize(width: collectionView.frame.width - 32, height: viewModel.dummyRecord.isEmpty ? collectionView.frame.height - keyboardHeight : 43)
        }
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
