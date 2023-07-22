//
//  AddLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class AddLocationViewController: BaseViewController {
    let dummyLocation = dummyLocationData()
    var selectedLocation: String?
    
    weak var delegate: SelectedLocationDelegate?
    
    private let addLocationView = UIView()
    private let locationTextField = UITextField()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideKeyboardWhenTappedAround(view)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        addLocationView.layer.cornerRadius = 24
        addLocationView.backgroundColor = .colorF9F8F7
        
        locationTextField.layer.cornerRadius = 8
        locationTextField.backgroundColor = .colorF5F3F0
        locationTextField.placeholder = "장소 검색"
        locationTextField.font = .body01
        locationTextField.addLeftPadding()
        locationTextField.returnKeyType = .search
        locationTextField.delegate = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(addLocationView)
        addLocationView.addSubview(locationTextField)
        addLocationView.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addLocationView.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(500)
        }
        
        locationTextField.snp.makeConstraints {
            $0.top.equalTo(addLocationView).offset(30)
            $0.leading.equalTo(addLocationView).offset(20)
            $0.trailing.equalTo(addLocationView).offset(-20)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(locationTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(addLocationView)
            $0.bottom.equalTo(addLocationView).offset(-25)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !addLocationView.frame.contains(touch.location(in: view)) else {
            return
        }

        dismiss(animated: false)
    }
}

extension AddLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.registerId, for: indexPath) as? LocationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let location = dummyLocation[indexPath.row]
        let title = location.title
        let address = location.address
        
        cell.configure(with: title, address: address)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = dummyLocation[indexPath.row].title
        selectedLocation = location
        
        delegate?.selectLocation(location)
        dismiss(animated: false)
    }
}

extension AddLocationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextField.resignFirstResponder()
        return true
    }
}

protocol SelectedLocationDelegate: AnyObject {
    func selectLocation(_ selectedLocation: String)
}
