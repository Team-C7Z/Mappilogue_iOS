//
//  AddLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class AddLocationViewController: BaseViewController {
    let dummyLocation = dummyLocationData()
    var onLocationSelected: ((Location) -> Void)?

    private let addLocationView = UIView()
    private let searchBar = SearchBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        addLocationView.layer.cornerRadius = 24
        addLocationView.backgroundColor = .colorF9F8F7
        
        searchBar.configure("장소 검색")
        searchBar.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(addLocationView)
        addLocationView.addSubview(searchBar)
        addLocationView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addLocationView.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(500)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(addLocationView).offset(30)
            $0.leading.equalTo(addLocationView).offset(4)
            $0.trailing.equalTo(addLocationView).offset(4)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(addLocationView)
            $0.bottom.equalTo(addLocationView).offset(-31)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !addLocationView.frame.contains(touch.location(in: view)) else {
            return
        }

        dismiss(animated: false)
    }
}

extension AddLocationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.registerId, for: indexPath) as? LocationCell else { return UICollectionViewCell() }
        
        let location = dummyLocation[indexPath.row]
        let title = location.title
        let address = location.address
        
        cell.configure(with: title, address: address)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 43)
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
        let location = dummyLocation[indexPath.row]
        dismiss(animated: false) {
            self.onLocationSelected?(location)
        }
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
