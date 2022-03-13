//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import UIKit

class NewsListViewController: UIViewController {
    private let cellIdentifier = "NewsListCell"
    var viewModel:NewsListViewModel?
    private var newsListArray = [News]()
    var indexOfPageToRequest = 0
    
    lazy private var newsListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: Constants.NewsListConstants.ERROR_TITLE_FONT_SIZE)
        label.text = NSLocalizedString("ERROR_TEXT", comment: "")
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("TRY_AGAIN", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("DAILY_NEWS", comment: "")
        view.backgroundColor = .white
        view.addSubview(newsListTableView)
        view.addSubview(errorLabel)
        view.addSubview(tryAgainButton)
        setUpPullToRefresh()
        setupConstraints()
        loadNewsData()
    }
    
    func setUpPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        newsListTableView.refreshControl = refreshControl
    }
    
    @objc private func refresh(refreshControl: UIRefreshControl) {
        loadNewsData()
        refreshControl.endRefreshing()
    }
    
    @objc private func loadData() {
        loadNewsData()
    }
    
    private func loadNewsData(category: NewsCategory? = .entertainment) {
        self.showLoader()
        viewModel?.getNewsData(searchQuery: "", category: category, pageNumber: 0) {[weak self] newsList, error in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoader()
                guard let weakSelf = self else {
                    return
                }
                if error == nil {
                    if let newsList = newsList {
                        weakSelf.newsListTableView.isHidden = false
                        weakSelf.errorLabel.isHidden = true
                        weakSelf.tryAgainButton.isHidden = true
                        weakSelf.newsListArray = newsList
                        weakSelf.newsListTableView.reloadData()
                    } else {
                        weakSelf.errorLabel.isHidden = false
                        weakSelf.tryAgainButton.isHidden = false
                        weakSelf.newsListTableView.isHidden = true
                    }
                } else {
                    weakSelf.showAlertMessage(title: NSLocalizedString("ERROR", comment: ""), message: error?.localizedDescription, style: .alert)
                    weakSelf.newsListTableView.isHidden = true
                    weakSelf.errorLabel.isHidden = false
                    weakSelf.tryAgainButton.isHidden = false
                }
            }
        }
    }
        
    private func setupConstraints() {
        newsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        tryAgainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 30).isActive = true
        tryAgainButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    // Loading View to mask the current view and its actions.
    func showOverlay() {
        let overlayView = UIView(frame: (CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)))
        overlayView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissSideBar))
        gestureRecognizer.numberOfTapsRequired = 1
        view.addSubview(overlayView)
    }
    
    @objc func dismissSideBar() {
        
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsListCell {
            let newsObject = newsListArray[indexPath.row]
            cell.newsTitleLabel.text = newsObject.title
            cell.tag = indexPath.row
            cell.newsDescriptionLabel.text = newsObject.description
            cell.loadNewsImage(path: newsObject.imageUrl, index: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.NewsListConstants.DEFAULT_CELL_HEIGHT
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calculates where the user is in the scrollview
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            // increments the number of the page to request
            indexOfPageToRequest += 1
            
            // call your API for more data
            viewModel?.getNewsData(searchQuery: "", category: .entertainment, pageNumber: indexOfPageToRequest) {[weak self] newsList, error in
                DispatchQueue.main.async {
                    guard let weakSelf = self else { return }
                    if error == nil, let newsList = newsList {
                        weakSelf.newsListArray.append(contentsOf: newsList)
                        weakSelf.newsListTableView.reloadData()
                    }
                }
            }
        }
    }
}

