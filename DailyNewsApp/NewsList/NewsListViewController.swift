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
    private var newsListArray = [News]()
    
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
        setupMenuButton()
        setupConstraints()
        loadNewsData()
    }
    
    @objc private func loadNewsData() {
        viewModel.getNewsData(searchQuery: "", category: .entertainment, pageNumber: 0) {[weak self] newsList, error in
            DispatchQueue.main.async { [weak self] in 
                
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
#warning("Add alert")
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
    
    private func setupMenuButton() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(menuButtonTapped))
        self.navigationItem.leftBarButtonItem  = menuButton
        
    }
    
    @objc func menuButtonTapped() {
        
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
            cell.newsDescriptionLabel.text = newsObject.description
            
            if let imagePath = newsObject.imageUrl {
                cell.actvityIndicator.startAnimating()
                viewModel.getNewsImage(path: imagePath) { imageData, error in
                    DispatchQueue.main.async {
                        cell.actvityIndicator.stopAnimating()
                        if let imageData = imageData {
                            cell.newsImageView.image = UIImage(data: imageData)
                        } else {
                            cell.newsImageView.image = UIImage(named: "Placeholder")
                        }
                    }
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.NewsListConstants.DEFAULT_CELL_HEIGHT
    }
}

