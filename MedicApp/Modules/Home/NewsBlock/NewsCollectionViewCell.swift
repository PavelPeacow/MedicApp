//
//  NewsCollectionViewCell.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewsCollectionViewCell"
    
    lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.layer.zPosition = 1
        return label
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsDescription, newsPrice])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var newsDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var newsPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var newsImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.zPosition = -1
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(newsTitle)
        contentView.addSubview(descriptionStackView)
        descriptionStackView.addSubview(newsImage)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(news: News) {
        newsTitle.text = news.name
        newsDescription.text = news.description
        newsPrice.text = news.price
        newsPrice.text?.append(" ₽")
        guard let url = URL(string: news.image) else { return }
        newsImage.loadImage(imageURL: url)
    }
    
}

extension NewsCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsTitle.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 0),
            newsTitle.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 12),
            
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: 0),
            descriptionStackView.topAnchor.constraint(greaterThanOrEqualTo: newsTitle.bottomAnchor, constant: 3),
            descriptionStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 100),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
