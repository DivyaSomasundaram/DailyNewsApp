//
//  NewsCategoryViewController.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import UIKit

class NewsCategoryViewController: UIViewController {

    private let cellIdentifier = "NewsCategoryCell"
    var viewModel: NewsCategoryViewModel?
    
    lazy private var newsCategoriesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        self.view.backgroundColor = .white
        self.view.addSubview(newsCategoriesTableView)
        setupCloseButton()
        setupConstraints()
    }
    
    private func setupConstraints() {
        newsCategoriesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsCategoriesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsCategoriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsCategoriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationItem.leftBarButtonItem  = closeButton
    }
    
    @objc func closeButtonTapped() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

extension NewsCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.newsCategoryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.text = viewModel?.newsCategoryList[indexPath.row].rawValue
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
