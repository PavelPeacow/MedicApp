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
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryTitle)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 12
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        categoryTitle.text = title
    }
    
    func setSelected() {
        contentView.backgroundColor = .blue
        categoryTitle.textColor = .white
    }
    
    func setUnSelected() {
        contentView.backgroundColor = .systemGray6
        categoryTitle.textColor = .gray
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
