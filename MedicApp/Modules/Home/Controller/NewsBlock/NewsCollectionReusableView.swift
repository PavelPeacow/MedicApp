//
//  NewsCollectionReusableView.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

class NewsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "NewsCollectionReusableView"
    
    lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(newsTitle)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        newsTitle.text = title
    }
    
}

extension NewsCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            newsTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
}
