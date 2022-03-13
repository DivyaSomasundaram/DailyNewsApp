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
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
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
        setupConstraints()

        loadNewsImage()
        self.titleLabel.text = viewModel?.news?.title
        self.descriptionTextView.text = viewModel?.news?.description
    }
    
    func setupConstraints() {
        newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        newsImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: Constants.NewsDetailConstant.IMAGE_HEIGHT).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20).isActive = true
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
