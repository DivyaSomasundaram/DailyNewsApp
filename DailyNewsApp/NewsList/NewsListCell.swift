//
//  NewsListCell.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import UIKit

class NewsListCell: UITableViewCell {
    lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.NewsListConstants.TITLE_FONT_SIZE)
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.NewsListConstants.DESCRIPTION_FONT_SIZE)
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var newsImageLabel: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(newsTitleLabel)
        self.contentView.addSubview(newsDescriptionLabel)
        self.contentView.addSubview(newsImageLabel)
        setupContraints()
    }
    
    func setupContraints() {
        newsImageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        newsImageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        newsImageLabel.widthAnchor.constraint(equalToConstant: Constants.NewsListConstants.NEWS_IMAGE_WIDTH).isActive = true
        newsImageLabel.heightAnchor.constraint(equalToConstant: Constants.NewsListConstants.NEWS_IMAGE_HEIGHT).isActive = true
        
        newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageLabel.trailingAnchor).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.NewsListConstants.DEFAULT_PADDING).isActive = true
        newsTitleLabel.bottomAnchor.constraint(equalTo: newsDescriptionLabel.topAnchor, constant: Constants.NewsListConstants.DEFAULT_PADDING).isActive = true
        
        newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsImageLabel.trailingAnchor).isActive = true
        newsDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
