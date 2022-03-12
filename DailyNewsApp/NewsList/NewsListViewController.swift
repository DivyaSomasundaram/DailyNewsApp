//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private let cellIdentifier = "NewsListCell"
    private let viewModel = NewsListViewModel()
    
    lazy private var newsListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("DAILY_NEWS", comment: "")
        view.backgroundColor = .white
        view.addSubview(newsListTableView)
        setupMenuButton()
        setupConstraints()
        loadNewsData()
    }
    
    private func loadNewsData() {
        viewModel.getNewsData(searchQuery: "", category: .entertainment, pageNumber: 0) {[weak self] newsList, error in
            guard let weakSelf = self else {
                return
            }
            weakSelf.newsListTableView.reloadData()
        }
    }
    
    private func setupConstraints() {
        newsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        newsListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupMenuButton() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(menuButtonTapped))
        self.navigationItem.leftBarButtonItem  = menuButton
        
    }
    
    @objc func menuButtonTapped() {
        
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsListCell {
//            cell.newsTitleLabel.text = viewModel.newsListArray[indexPath.row]
//            cell.newsDescriptionLabel.text = viewModel.newsListArray[indexPath.row]
            cell.newsImageLabel.image = UIImage(named: "Menu")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.NewsListConstants.DEFAULT_CELL_HEIGHT
    }
}

