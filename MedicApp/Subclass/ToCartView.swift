//
//  AddToCartView.swift
//  MedicApp
//
//  Created by Павел Кай on 20.03.2023.
//

import UIKit

class ToCartView: UIView {
    
    var allPriceCount = 0 {
        didSet {
            allPrice.text = "\(allPriceCount) ₽"
        }
    }
    
    lazy var back: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cartImage, cartLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return image
    }()
    
    lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "В корзину"
        return label
    }()
    
    lazy var allPrice: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(back)
        back.addSubview(stackView)
        back.addSubview(allPrice)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            back.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            back.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            back.heightAnchor.constraint(equalToConstant: 55),
            back.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: back.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: allPrice.leadingAnchor, constant: -16),
            
            allPrice.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -16),
            allPrice.centerYAnchor.constraint(equalTo: back.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
