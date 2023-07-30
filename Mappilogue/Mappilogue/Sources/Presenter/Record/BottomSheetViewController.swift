//
//  BottomSheetViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class BottomSheetViewController: BaseViewController {
    var emptyCellHeight: CGFloat = 196
    
    private let barImage = UIImageView()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(EmptyRecordCell.self, forCellReuseIdentifier: EmptyRecordCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .colorF9F8F7
        
        barImage.image = UIImage(named: "bottomSheetBar")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(barImage)
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barImage.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view).offset(12)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view).offset(24)
            $0.width.equalTo(view)
            $0.height.equalTo(view.frame.height - 24)
        }
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyRecordCell.registerId, for: indexPath) as? EmptyRecordCell else { return UITableViewCell() }
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return emptyCellHeight - 56
    }
}
