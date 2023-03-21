//
//  CartViewMain.swift
//  MedicApp
//
//  Created by Павел Кай on 20.03.2023.
//

import UIKit

protocol CartCollectionViewCellDelegate: AnyObject {
    func didTapStepper(_ catalogItem: CatalogItem)
}

class CartViewMain: UIView {
    
    var catalogItem: CatalogItem!
    
    weak var delegate: CartCollectionViewCellDelegate?
    
    var numberOfPacient = 1 {
        willSet {
            pacientTitle.text = "\(newValue) пациент"
            
            let totalPrice = price * newValue
            catalogItem.changePrice(totalPrice)
            
            catalogItemPrice.text = "\(totalPrice) ₽"
            
            delegate?.didTapStepper(catalogItem)
        }
    }
    
    var price = 0
    
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
        let stackView = UIStackView(arrangedSubviews: [catalogItemPrice, stepperContentStackView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var catalogItemPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var stepperContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pacientTitle, stepper])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var pacientTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.backgroundColor = .systemGray5
        stepper.minimumValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(didTapStepper), for: .valueChanged)
        stepper.layer.cornerRadius = 8
        return stepper
    }()
    
    lazy var closeItem: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 1
        
        layer.cornerRadius = 12
        
        addSubview(contentStackView)
        addSubview(closeItem)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(catalogItem: CatalogItem) {
        self.catalogItem = catalogItem
        catalogItemTitle.text = catalogItem.name
        price = Int(catalogItem.price) ?? 0
        catalogItemPrice.text = catalogItem.price + " ₽"
        
        numberOfPacient = catalogItem.numberOfPeople ?? 1
        stepper.value = Double(catalogItem.numberOfPeople ?? 1)
    }
    
}
    
extension CartViewMain {
    
    @objc func didTapStepper(_ sender: UIStepper) {
        numberOfPacient = Int(sender.value)
    }
    
}

extension CartViewMain {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            closeItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            closeItem.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeItem.heightAnchor.constraint(equalToConstant: 20),
            closeItem.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
