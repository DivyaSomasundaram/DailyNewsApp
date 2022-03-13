//
//  NewsDetailsViewController.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 13/03/22.
//

import UIKit

/// Class displayes news details.
class NewsDetailsViewController: UIViewController {
    var viewModel: NewsDetailViewModel?
    lazy private var newsImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.backgroundColor = .lightGray
        return imageview
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    lazy private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkGray
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy private var updateOnTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Updated on:"
        return label
    }()
    
    lazy private var publishedDate: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.news?.title
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(newsImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionTextView)
        self.view.addSubview(updateOnTitle)
        self.view.addSubview(publishedDate)

        setupConstraints()

        loadNewsImage()
        if let news = viewModel?.news {
            self.titleLabel.text = news.title
            self.descriptionTextView.text = news.description
            let publishedDate = news.publishedAt ?? ""
            self.publishedDate.text = viewModel?.getDateInDisplayFormat(publishedDate)
        }
    }
    
    func setupConstraints() {
        newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        newsImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: Constants.NewsDetailConstant.IMAGE_HEIGHT).isActive = true
        
        updateOnTitle.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10).isActive = true
        updateOnTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        publishedDate.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10).isActive = true
        publishedDate.leadingAnchor.constraint(equalTo: updateOnTitle.trailingAnchor, constant: 10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: publishedDate.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    /// Loads News image
    func loadNewsImage() {
        if let imagePath = viewModel?.news?.imageUrl {
            let imageLoader =  ImageLoader.init(path: imagePath)
            imageLoader.loadImage { [weak self] data, error in
                DispatchQueue.main.async {
                    guard let weakSelf = self else { return }
                    if error == nil, let data = data {
                        weakSelf.newsImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
