//
//  SearchResultViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchResultViewController: BaseViewController {
    //let dummyLocation = dummyLocationData()
    let dummyLocation = [Location]()
    let dummyMark = dummyMarkData()
    var keyboardHeight: CGFloat = 0
    
    var searchType: SearchType = .location {
        didSet {
            setSearchButtonDesign()
        }
    }
    
    private let stackView = UIStackView()
    private var locationButton = UIButton()
    private var markButton = UIButton()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
  
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(EmptySearchCell.self, forCellWithReuseIdentifier: EmptySearchCell.registerId)
        collectionView.register(SearchLocationCell.self, forCellWithReuseIdentifier: SearchLocationCell.registerId)
        collectionView.register(SearchMarkCell.self, forCellWithReuseIdentifier: SearchMarkCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        locationButton = createSearchButton("장소")
        markButton = createSearchButton("기록")
        setSearchButtonDesign()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(markButton)
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
        print(keyboardHeight)
    }
    
    private func createSearchButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .body03
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    private func setSearchButtonDesign() {
        locationButton.setTitleColor(searchType == .location ? .colorFFFFFF : .color707070, for: .normal)
        markButton.setTitleColor(searchType == .mark ? .colorFFFFFF : .color707070, for: .normal)
        locationButton.backgroundColor = searchType == .location ? .color2EBD3D : .colorF5F3F0
        markButton.backgroundColor = searchType == .mark ? .color2EBD3D : .colorF5F3F0
    }
    
    @objc func searchButtonTapped(_ button: UIButton) {
        switch button {
        case locationButton:
            searchType = .location
        case markButton:
            searchType = .mark
        default:
            break
        }
        collectionView.reloadData()
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchType {
        case .location:
            return dummyLocation.isEmpty ? 1 : dummyLocation.count
        case .mark:
            return dummyMark.isEmpty ? 1 : dummyMark.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchType {
        case .location:
            if dummyLocation.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptySearchCell.registerId, for: indexPath) as? EmptySearchCell else { return UICollectionViewCell() }
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchLocationCell.registerId, for: indexPath) as? SearchLocationCell else { return UICollectionViewCell() }
         
                let location = dummyLocation[indexPath.row]
                cell.configure(with: location)
                
                return cell
            }
        case .mark:
            if dummyMark.isEmpty {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptySearchCell.registerId, for: indexPath) as? EmptySearchCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMarkCell.registerId, for: indexPath) as? SearchMarkCell else { return UICollectionViewCell() }
                
                let mark = dummyMark[indexPath.row]
                cell.configure(with: mark)
                    
                return cell
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch searchType {
        case .location:
            return CGSize(width: collectionView.frame.width - 32, height: dummyLocation.isEmpty ? collectionView.frame.height - keyboardHeight : 44)
        case .mark:
            return CGSize(width: collectionView.frame.width - 32, height: dummyMark.isEmpty ? collectionView.frame.height - keyboardHeight : 43)
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
