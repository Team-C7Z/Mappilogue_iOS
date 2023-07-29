//
//  SearchResultViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchResultViewController: BaseViewController {
    private let stackView = UIStackView()
    private let locationButton = UIButton()
    private let markButton = UIButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(EmptySearchCell.self, forCellReuseIdentifier: EmptySearchCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        locationButton.layer.cornerRadius = 12
        locationButton.backgroundColor = .color2EBD3D
        locationButton.setTitle("장소", for: .normal)
        locationButton.setTitleColor(.colorFFFFFF, for: .normal)
        locationButton.titleLabel?.font = .body02
        
        markButton.layer.cornerRadius = 12
        markButton.backgroundColor = .colorF5F3F0
        markButton.setTitle("기록", for: .normal)
        markButton.setTitleColor(.color707070, for: .normal)
        markButton.titleLabel?.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
       
        view.addSubview(stackView)
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(markButton)
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptySearchCell.registerId, for: indexPath) as? EmptySearchCell else { return UITableViewCell() }
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height - 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
