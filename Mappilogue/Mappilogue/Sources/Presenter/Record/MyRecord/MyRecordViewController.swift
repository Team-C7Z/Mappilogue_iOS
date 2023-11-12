//
//  MyRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MyRecordViewController: BaseViewController {
    private var categoryViewModel = CategoryViewModel()
    var categories: [Category] = []
    var totalCategoryCount: Int = 0
    var isNewWrite: Bool = false
    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategoryData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("나의 기록", backButtonAction: #selector(popToRootViewController))
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
    
    @objc func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension MyRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? categories.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = configureMyRecordCategoryCell(for: indexPath, in: tableView)
            return cell
        case 1:
            let cell = configureCategorySettingCell(for: indexPath, in: tableView)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func configureMyRecordCategoryCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRecordCategoryCell.registerId, for: indexPath) as? MyRecordCategoryCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let totalCategory = Category(id: 0, title: "전체", isMarkedInMap: .inactive, markCount: totalCategoryCount)
        let category = indexPath.row == 0 ? totalCategory : categories[indexPath.row - 1]
        let isLast = indexPath.row == categories.count
        cell.configure(with: category, isLast: isLast)
        
        return cell
    }
    
    private func configureCategorySettingCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorySettingCell.registerId, for: indexPath) as? CategorySettingCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 41 : 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            didSelectMyRecordCategoryCell(indexPath)
        case 1:
            didSelectCategorySettingCell()
        default:
            break
        }
    }
    
    func didSelectMyRecordCategoryCell(_ indexPath: IndexPath) {
        let myCategoryViewController = MyCategoryViewController()
        myCategoryViewController.categoryId = indexPath.row == 0 ? 0 : categories[indexPath.row-1].id
        myCategoryViewController.categoryName = indexPath.row == 0 ? "전체" : categories[indexPath.row-1].title
        myCategoryViewController.onModifyCategory = { categoryName in
            self.categories[indexPath.row-1].title = categoryName
            self.tableView.reloadData()
        }
        myCategoryViewController.onDeleteCategory = {
            self.categories.remove(at: indexPath.row-1)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(myCategoryViewController, animated: true)
    }
    
    func didSelectCategorySettingCell() {
        let categorySettingViewController = CategorySettingViewController()
        navigationController?.pushViewController(categorySettingViewController, animated: true)
    }
}

extension MyRecordViewController {
    private func loadCategoryData() {
        categoryViewModel.getCategory()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                guard let result = response.result else { return }
                
                self.categories = result.markCategories
                self.totalCategoryCount = result.totalCategoryMarkCount
                self.tableView.reloadData()
            }
            .store(in: &categoryViewModel.cancellables)
    }
}
