//
//  CategoryCollectionViewCell.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identfier = "CategoryCollectionViewCell"
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryTitle)
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 12
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        categoryTitle.text = title
    }
    
}

extension CategoryCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categoryTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
        ])
    }
    
}
