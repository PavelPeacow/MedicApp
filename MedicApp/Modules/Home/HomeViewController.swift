//
//  HomeViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit
import BottomSheet

enum Sections: CaseIterable {
    case newsBlock
    case catalog
    
    var sectionTitle: String {
        switch self {
        case .newsBlock:
            return "Акции и новости"
        case .catalog:
            return "Каталог анализов"
        }
    }
}

extension NSCollectionLayoutSection {
    
    static func newsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(280), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    static func catalogSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

class HomeViewController: UIViewController {
    
    var news = [News]()
    lazy var catalog = [CatalogItem]()
    lazy var filteredArrat = [CatalogItem]()
    
    var selectedCategory: String = "Популярные"
    
    var selectedItemsForBy = [CatalogItem]()
    
    lazy var cartView: ToCartView = {
        let view = ToCartView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCartView))
        view.addGestureRecognizer(gesture)
        view.isHidden = true
        return view
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchViewController())
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Искать анализы"
        return searchController
    }()
    
    lazy var pullRefresh: UIRefreshControl = {
        let resfresh = UIRefreshControl()
        resfresh.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        return resfresh
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch Sections.allCases[section] {
            case .newsBlock:
                return .newsSection()
            case .catalog:
                return .catalogSection()
            }
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(NewsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsCollectionReusableView.identifier)
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCollectionViewCell.identifier)
        collectionView.register(CatalogCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CatalogCollectionReusableView.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        
        collectionView.addSubview(pullRefresh)
        
        view.addSubview(cartView)
        
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        Task {
            view.alpha = 0.5
            loadingView.startAnimating()
            do {
                let news = try await APIManager().makeAPICall(type: [News].self, endpoint: .news)
                let catalog = try await APIManager().makeAPICall(type: [CatalogItem].self, endpoint: .catalog)
                
                self.news = news
                self.catalog = catalog

                filteredArrat = catalog.filter { $0.category == "Популярные" }
                
                collectionView.reloadData()
    
            } catch {
                print(error)
            }
            view.alpha = 1.0
            loadingView.removeFromSuperview()
        }
        
        
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        setConstraints()
    }
    
    func getCategories() -> [String] {
        Set(catalog.map { $0.category }).sorted(by: { $0 > $1 })
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let vc = searchController.searchResultsController as! SearchViewController
        
        guard let text = searchController.searchBar.text, text.count > 0 else {
            vc.filterCatalog(items: [])
            return
        }
        
        vc.filterCatalog(items: catalog.filter({ $0.name.lowercased().contains(text.lowercased()) }))
        
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Sections.allCases[section] {
            
        case .newsBlock:
            return news.count
        case .catalog:
            return filteredArrat.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Sections.allCases[indexPath.section] {
            
        case .newsBlock:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
            
            let newsItem = news[indexPath.item]

            cell.configure(news: newsItem)
            
            return cell
        case .catalog:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.identifier, for: indexPath) as! CatalogCollectionViewCell
            
            let catalogItem = filteredArrat[indexPath.row]
            
            cell.delegate = self
            
            if selectedItemsForBy.contains(where: { $0.name == catalogItem.name }) {
                cell.setBtnState(isAddItemToCart: true)
                cell.isAddItemToCart = true
            }
            
            cell.configure(catalogItem: catalogItem)
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch Sections.allCases[indexPath.section] {
            
        case .newsBlock:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NewsCollectionReusableView.identifier, for: indexPath) as! NewsCollectionReusableView
            
            let section = Sections.allCases[indexPath.section]
            
            header.configure(title: section.sectionTitle)
            
            return header
        case .catalog:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CatalogCollectionReusableView.identifier, for: indexPath) as! CatalogCollectionReusableView
            
            header.delegate = self
            
            let section = Sections.allCases[indexPath.section]
            let categories = getCategories()
            
            header.configure(title: section.sectionTitle, categoriesDataSource: categories, selectedCategory: selectedCategory)
            
            return header
        }

    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch Sections.allCases[indexPath.section] {
            
        case .newsBlock:
            return
        case .catalog:
            let item = filteredArrat[indexPath.row]
            let vc = CatalogDetailViewController()
            vc.preferredContentSize = .init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 150)
            vc.delegate = self
            let isContains = selectedItemsForBy.contains(where: { $0.id == item.id })
            vc.configure(catalogItem: item, isAddItemToCart: isContains)
//            present(vc, animated: true)
            presentBottomSheet(viewController: vc, configuration: .init(cornerRadius: 12, pullBarConfiguration: .hidden, shadowConfiguration: .default))
        }
    }
    
    
}

extension HomeViewController: CatalogCollectionReusableViewDelegate {
    
    func didSelectCategory(_ category: String) {
        selectedCategory = category
        filteredArrat = catalog.filter { $0.category == category }
        UIView.transition(with: collectionView, duration: 0.15, options: .transitionCrossDissolve) {
            self.collectionView.reloadData()
        }

    }
    
}

extension HomeViewController: CatalogCollectionViewCellDelegate {
    
    
    func didAddCatalogItemToCart(_ item: CatalogItem, isAddItemToCart: Bool) {
        print(isAddItemToCart)
        if isAddItemToCart {
            selectedItemsForBy.append(item)
            cartView.allPriceCount += Int(item.price) ?? 0
        } else {
            let removeIndex = selectedItemsForBy.firstIndex(where: { $0.name == item.name }) ?? 0
            selectedItemsForBy.remove(at: removeIndex)
            cartView.allPriceCount -= Int(item.price) ?? 0
            print(removeIndex)
            print(selectedItemsForBy)
        }
        
        if selectedItemsForBy.isEmpty {
            cartView.isHidden = true
            collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            cartView.isHidden = false
            collectionView.contentInset = .init(top: 0, left: 0, bottom: 120, right: 0)
        }
    }
    
}

extension HomeViewController: CatalogDetailViewControllerDelegate {
    
    func didAddItemToCart(_ catalogItem: CatalogItem, isAddItemToCart: Bool) {
        print(isAddItemToCart)
        if isAddItemToCart {
            selectedItemsForBy.append(catalogItem)
            cartView.allPriceCount += Int(catalogItem.price) ?? 0
        } else {
            let removeIndex = selectedItemsForBy.firstIndex(where: { $0.name == catalogItem.name }) ?? 0
            selectedItemsForBy.remove(at: removeIndex)
            cartView.allPriceCount -= Int(catalogItem.price) ?? 0
            print(removeIndex)
            print(selectedItemsForBy)
        }
        collectionView.reloadData()
        if selectedItemsForBy.isEmpty {
            cartView.isHidden = true
            collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            cartView.isHidden = false
            collectionView.contentInset = .init(top: 0, left: 0, bottom: 120, right: 0)
        }
    }
    
}

extension HomeViewController {
    
    @objc func didPullRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        Task {
            do {
                let news = try await APIManager().makeAPICall(type: [News].self, endpoint: .news)
                let catalog = try await APIManager().makeAPICall(type: [CatalogItem].self, endpoint: .catalog)
                
                self.news = news
                self.catalog = catalog

                filteredArrat = catalog.filter { $0.category == "Популярные" }
                
                collectionView.reloadData()
                print(catalog)
                sender.endRefreshing()
            } catch {
                print(error)
            }
        }

    }
    
    @objc func didTapCartView() {
        let vc = CartViewController()
        vc.configure(selectedCatalogItems: selectedItemsForBy)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension HomeViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartView.heightAnchor.constraint(equalToConstant: 105),
        ])
    }
    
}
