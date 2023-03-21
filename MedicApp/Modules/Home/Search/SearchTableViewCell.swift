//
//  SearchTableViewCell.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchItemDescription, priceStackView])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchItemDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchItemPrice, searchItemDate])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var searchItemPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var searchItemDate: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contentStackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(description: String, price: String, date: String) {
        searchItemDescription.text = description
        searchItemPrice.text = price
        searchItemDate.text = date
    }
    
    
}

extension SearchTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        ])
    }
    
}
