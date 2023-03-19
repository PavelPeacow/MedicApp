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
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .blue
        
        contentView.addSubview(newsTitle)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        newsTitle.text = title
       
    }
    
}

extension NewsCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        ])
    }
    
}
