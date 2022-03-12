//
//  NewsListCell.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import UIKit

class NewsListCell: UITableViewCell {
    
    let viewModel = NewsListCellViewModel()
    lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.NewsListConstants.TITLE_FONT_SIZE)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.NewsListConstants.DESCRIPTION_FONT_SIZE)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.textColor = .darkGray
        return label
    }()
    
    lazy var newsImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.backgroundColor = .lightGray
        return imageview
    }()
    
    lazy var actvityIndicator: UIActivityIndicatorView = {
        let actvityIndicator = UIActivityIndicatorView.init(frame: .zero)
        actvityIndicator.translatesAutoresizingMaskIntoConstraints = false
        actvityIndicator.style = .medium
        actvityIndicator.color = .white
        return actvityIndicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.contentView.addSubview(newsTitleLabel)
        self.contentView.addSubview(newsDescriptionLabel)
        self.newsImageView.addSubview(actvityIndicator)
        self.contentView.addSubview(newsImageView)
        setupContraints()
    }
    
    private func setupContraints() {
        newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: Constants.NewsListConstants.NEWS_IMAGE_WIDTH).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: Constants.NewsListConstants.NEWS_IMAGE_HEIGHT).isActive = true
        
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.NewsListConstants.DEFAULT_PADDING).isActive = true
        newsTitleLabel.bottomAnchor.constraint(equalTo: newsDescriptionLabel.topAnchor, constant: Constants.NewsListConstants.TITLE_PADDING).isActive = true
        
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: Constants.NewsListConstants.TITLE_PADDING).isActive = true
        newsDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        newsDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        actvityIndicator.centerXAnchor.constraint(equalTo: self.newsImageView.centerXAnchor).isActive = true
        actvityIndicator.centerYAnchor.constraint(equalTo: self.newsImageView.centerYAnchor).isActive = true
    }
    
    func loadNewsImage(path: String?, index: IndexPath) {
        if let imagePath = path, self.tag == index.row {
            self.newsImageView.image = UIImage(named: "Placeholder")
            self.actvityIndicator.startAnimating()
            viewModel.getNewsImage(path: imagePath) { imageData, error in
                DispatchQueue.main.async {
                    self.actvityIndicator.stopAnimating()
                    if let imageData = imageData {
                        self.newsImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
