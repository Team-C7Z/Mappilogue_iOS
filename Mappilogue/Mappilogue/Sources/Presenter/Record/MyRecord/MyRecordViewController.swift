//
//  MyRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MyRecordViewController: BaseViewController {
    let dummyCateogry = dummyCategoryData()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(MyRecordCategoryCell.self, forCellReuseIdentifier: MyRecordCategoryCell.registerId)
        tableView.register(CategorySettingCell.self, forCellReuseIdentifier: CategorySettingCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar("나의 기록", backButtonAction: #selector(backButtonTapped))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension MyRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dummyCateogry.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRecordCategoryCell.registerId, for: indexPath) as? MyRecordCategoryCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            let category = dummyCateogry[indexPath.row]
            let isLast = indexPath.row == dummyCateogry.count-1
            cell.configure(with: category, isLast: isLast)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorySettingCell.registerId, for: indexPath) as? CategorySettingCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
        default:
            return UITableViewCell()
        }
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 41 : 40
    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
