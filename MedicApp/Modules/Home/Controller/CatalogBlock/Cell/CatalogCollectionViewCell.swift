//
//  CatalogCollectionViewCell.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

protocol CatalogCollectionViewCellDelegate: AnyObject {
    func didAddCatalogItemToCart(_ item: CatalogItem, isAddItemToCart: Bool)
}

class CatalogCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CatalogCollectionViewCell"
    
    weak var delegate: CatalogCollectionViewCellDelegate?
    
    var catalogItem: CatalogItem?
    var isAddItemToCart = false
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [catalogItemTitle, additionalContentStackView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var catalogItemTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var additionalContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceStackView, catalogItemAddBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [catalogItemDate, catalogItemPrice])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var catalogItemDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    lazy var catalogItemPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var catalogItemAddBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("Добавить", for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
        return btn
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isAddItemToCart = false
        setBtnState(isAddItemToCart: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(contentStackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(catalogItem: CatalogItem) {
        catalogItemTitle.text = catalogItem.name
        catalogItemDate.text = catalogItem.time_result
        catalogItemPrice.text = catalogItem.price
        self.catalogItem = catalogItem
    }
    
    func setBtnState(isAddItemToCart: Bool) {
        if isAddItemToCart {
            catalogItemAddBtn.setTitle("Убрать", for: .normal)
            catalogItemAddBtn.setTitleColor(.blue, for: .normal)
            catalogItemAddBtn.backgroundColor = .clear
            catalogItemAddBtn.layer.borderColor = UIColor.blue.cgColor
            catalogItemAddBtn.layer.borderWidth = 1
        } else {
            catalogItemAddBtn.setTitle("Добавить", for: .normal)
            catalogItemAddBtn.setTitleColor(.white, for: .normal)
            catalogItemAddBtn.backgroundColor = .blue
            catalogItemAddBtn.layer.borderColor = nil
            catalogItemAddBtn.layer.borderWidth = 0
        }
    }
    
}

extension CatalogCollectionViewCell {
    
    @objc func didTapAddBtn() {
        guard let catalogItem = catalogItem else { return }
        
        if isAddItemToCart {
            delegate?.didAddCatalogItemToCart(catalogItem, isAddItemToCart: false)
            setBtnState(isAddItemToCart: false)
        } else {
            delegate?.didAddCatalogItemToCart(catalogItem, isAddItemToCart: true)
            setBtnState(isAddItemToCart: true)
        }
        
        isAddItemToCart.toggle()
        
    }
    
}

extension CatalogCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            catalogItemAddBtn.heightAnchor.constraint(equalToConstant: 40),
            catalogItemAddBtn.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}
