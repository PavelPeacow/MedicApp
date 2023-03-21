//
//  CartViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 20.03.2023.
//

import UIKit

class CartViewController: UIViewController {
    
    var catalogItems = [CatalogItem]()
    
    var price = 0 {
        didSet {
            priceTitle.text = "\(price) ₽"
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue
        return scrollView
    }()
    
    lazy var catalogItemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var back: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bin: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "bin")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var cartTitle: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sumTitle, priceTitle])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var sumTitle: UILabel = {
        let label = UILabel()
        label.text = "Сумма"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var priceTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var goToOrderBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Перейти к оформлению заказа", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(catalogItemsStackView)
        
        view.addSubview(back)
        back.addSubview(cartTitle)
        back.addSubview(bin)
        
        view.addSubview(contentStackView)
        
        view.addSubview(goToOrderBtn)
        
        setConstraints()
    }
    

    func configure(selectedCatalogItems: [CatalogItem]) {
        catalogItems = selectedCatalogItems
        let allPrice = catalogItems.reduce(into: 0, { $0 += Int($1.price) ?? 0 })
        price = allPrice
        
        for selectedCatalogItem in selectedCatalogItems {
            let view = CartViewMain()
            view.delegate = self
            view.configure(catalogItem: selectedCatalogItem)
            
            catalogItemsStackView.addArrangedSubview(view)
        }
        
    }
    
}

extension CartViewController: CartCollectionViewCellDelegate {
    
    func didTapStepper(_ catalogItem: CatalogItem) {
        let index = catalogItems.firstIndex(where: { $0.id == catalogItem.id }) ?? 0
        catalogItems[index] = catalogItem
        let allPrice = catalogItems.reduce(into: 0, { $0 += Int($1.price) ?? 0 })
        self.price = allPrice
    }
    
}

extension CartViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: contentStackView.topAnchor, constant: -40),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: catalogItemsStackView.bottomAnchor),

            catalogItemsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            catalogItemsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            catalogItemsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            back.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            back.heightAnchor.constraint(equalToConstant: 50),
            
            cartTitle.topAnchor.constraint(equalTo: back.safeAreaLayoutGuide.topAnchor, constant: 15),
            cartTitle.leadingAnchor.constraint(equalTo: back.leadingAnchor, constant: 20),
            
            bin.topAnchor.constraint(equalTo: back.safeAreaLayoutGuide.topAnchor, constant: 15),
            bin.trailingAnchor.constraint(equalTo: back.trailingAnchor, constant: -20),
            bin.heightAnchor.constraint(equalToConstant: 20),
            bin.widthAnchor.constraint(equalToConstant: 20),
            
            contentStackView.bottomAnchor.constraint(equalTo: goToOrderBtn.topAnchor, constant: -100),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            goToOrderBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            goToOrderBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            goToOrderBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            goToOrderBtn.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
}
