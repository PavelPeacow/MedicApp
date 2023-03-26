//
//  CatalogCollectionReusableView.swift
//  MedicApp
//
//  Created by Павел Кай on 19.03.2023.
//

import UIKit

protocol CatalogCollectionReusableViewDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class CatalogCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "CatalogCollectionReusableView"
    
    weak var delegate: CatalogCollectionReusableViewDelegate?
    
    var categoriesTitles = [String]()
    var selectedCell: String = "Популярные"
    
    lazy var catalogTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identfier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(catalogTitle)
        addSubview(collectionView)
        
        backgroundColor = .white
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, categoriesDataSource: [String], selectedCategory: String) {
        catalogTitle.text = title
        categoriesTitles = categoriesDataSource
        selectedCell = selectedCategory
        collectionView.reloadData()
    }
        
}

extension CatalogCollectionReusableView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identfier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.configure(title: categoriesTitles[indexPath.row])
        cell.setUnSelected()
        
        if cell.categoryTitle.text! == selectedCell {
            cell.setSelected()
        }
        
        return cell
    }
}

extension CatalogCollectionReusableView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = categoriesTitles[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell

        cell.setSelected()
        
        delegate?.didSelectCategory(item)
    }
    
}

extension CatalogCollectionReusableView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            catalogTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            catalogTitle.topAnchor.constraint(equalTo: topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: catalogTitle.bottomAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
}
