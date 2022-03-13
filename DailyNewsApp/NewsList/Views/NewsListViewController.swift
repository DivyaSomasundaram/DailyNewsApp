//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import UIKit

class NewsListViewController: UIViewController {
    var viewModel:NewsListViewModel?
    private var newsListArray = [News]()
    
    lazy private var newsListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListCell.self, forCellReuseIdentifier: Constants.NewsListConstants.CELL_IDENTIFIER)
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
        button.addTarget(self, action: #selector(loadNewsData), for: .touchUpInside)
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
    
    
    /// This method gets called when user do pull to refresh.
    /// - Parameter refreshControl: sender
    @objc private func refresh(refreshControl: UIRefreshControl) {
        loadNewsData()
        //Resetting page number while doing pull to refresh
        viewModel?.pageNumber = 0
        refreshControl.endRefreshing()
    }
    
    
    /// Loades news data and updates the UI.
    @objc private func loadNewsData() {
        self.showLoader()
        viewModel?.getNewsData() {[weak self] newsList, error in
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
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: newsListTableView.frame.size.width, height: Constants.NewsListConstants.FOOTER_HEIGHT))
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        footerView.addSubview(spinner)
        spinner.startAnimating()
        spinner.center = footerView.center
        return footerView
    }
}

// MARK: Table view Delegate.
extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NewsListConstants.CELL_IDENTIFIER, for: indexPath) as? NewsListCell {
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
        let contentHeight = newsListTableView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height && contentHeight > 0 {
            // calling API for more data.
            guard !(viewModel?.isPaginating ?? false) else { return }
            self.newsListTableView.tableFooterView = createSpinnerFooter()
            viewModel?.getNewsData(pagination: true) {[weak self] newsList, error in
                guard let weakSelf = self else { return }
                DispatchQueue.main.async {
                    weakSelf.newsListTableView.tableFooterView = nil
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

