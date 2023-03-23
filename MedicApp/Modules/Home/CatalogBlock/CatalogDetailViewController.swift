//
//  CatalogDetailViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 23.03.2023.
//

import UIKit

protocol CatalogDetailViewControllerDelegate {
    func didAddItemToCart(_ catalogItem: CatalogItem, isAddItemToCart: Bool)
}

class CatalogDetailViewController: UIViewController {
    
    var catalogItem: CatalogItem?
    
    var isAddItemToCart = false
    
    var delegate: CatalogDetailViewControllerDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var scrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var catalogDetailTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var decsriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [catalogDescriptionTitle, catalogDescription])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var catalogDescriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var catalogDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var preparationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [catalogPreparationTitle, catalogPreparationDescription])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var catalogPreparationTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Подготовка"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var catalogPreparationDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var itogStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultsStackView, materialStackView])
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var resultsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultTitle, resultDate])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var resultTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.text = "Результаты через:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var resultDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var materialStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [materialTitle, materialItem])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var materialTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.text = "Биоматериал:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    lazy var materialItem: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
        return btn
    }()
    
    func configure(catalogItem: CatalogItem, isAddItemToCart: Bool) {
        self.catalogItem = catalogItem
        catalogDetailTitle.text = catalogItem.name
        catalogDescription.text = catalogItem.description
        catalogPreparationDescription.text = catalogItem.preparation
        resultDate.text = catalogItem.time_result
        materialItem.text = catalogItem.bio
        addBtn.setTitle("Добавить за \(catalogItem.price) ₽", for: .normal)
        
        if isAddItemToCart {
            addBtn.setTitle("Убрать", for: .normal)
            addBtn.backgroundColor = .clear
            addBtn.layer.borderColor = UIColor.blue.cgColor
            addBtn.layer.borderWidth = 1
            addBtn.setTitleColor(.black, for: .normal)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        
        scrollView.addSubview(catalogDetailTitle)
        scrollView.addSubview(decsriptionStackView)
        scrollView.addSubview(preparationStackView)
        scrollView.addSubview(itogStackView)
        
        scrollView.addSubview(addBtn)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: addBtn.bottomAnchor, constant: 25),
            
            scrollContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            scrollContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            catalogDetailTitle.topAnchor.constraint(equalTo: scrollContainer.safeAreaLayoutGuide.topAnchor, constant: 24),
            catalogDetailTitle.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 20),
            catalogDetailTitle.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -20),
            
            decsriptionStackView.topAnchor.constraint(equalTo: catalogDetailTitle.bottomAnchor, constant: 20),
            decsriptionStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 20),
            decsriptionStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -20),
            
            preparationStackView.topAnchor.constraint(equalTo: decsriptionStackView.bottomAnchor, constant: 16),
            preparationStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 20),
            preparationStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -20),

            itogStackView.topAnchor.constraint(equalTo: preparationStackView.bottomAnchor, constant: 50),
            itogStackView.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 20),
            itogStackView.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -20),
            
            addBtn.topAnchor.constraint(equalTo: itogStackView.bottomAnchor, constant: 20),
            addBtn.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 20),
            addBtn.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor, constant: -20),
            addBtn.heightAnchor.constraint(equalToConstant: 55),
            
            
        ])
    }
}

extension CatalogDetailViewController {
    
    @objc func didTapAddBtn() {
        guard let catalogItem = catalogItem else { return }
        
        if isAddItemToCart {
            delegate?.didAddItemToCart(catalogItem, isAddItemToCart: false)
        } else {
            delegate?.didAddItemToCart(catalogItem, isAddItemToCart: true)
        }
        
        dismiss(animated: true)
    }
    
}
