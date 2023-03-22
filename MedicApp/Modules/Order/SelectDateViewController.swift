//
//  SelectDateViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 22.03.2023.
//

import UIKit


class TimeCollectioViewCell: UICollectionViewCell {
    
    static let identifier = "TimeCollectioViewCell"
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(time: String) {
        timeLabel.text = time
    }
    
}


class SelectDateViewController: UIViewController {
    
    var time = ["10:00", "13:00", "14:00", "15:00", "16:00", "18:00","19:00",]
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateTitle, selectDate, timeTitle, collectioView, confirmBtn])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var dateTitle: UILabel = {
       let label = UILabel()
        label.text = "Дата и время"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var selectDate: InputTextfieldWithTitle = {
        let date = InputTextfieldWithTitle(title: "Выберите дату")
        return date
    }()
    
    lazy var timeTitle: UILabel = {
       let label = UILabel()
        label.text = "Выберите время"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var collectioView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sec, env in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(16)
            group.edgeSpacing = .init(leading: .none, top: .fixed(4), trailing: .none, bottom: .fixed(4))
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        let collectonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectonView.delegate = self
        collectonView.dataSource = self
        collectonView.alwaysBounceVertical = false
        
        collectonView.register(TimeCollectioViewCell.self, forCellWithReuseIdentifier: TimeCollectioViewCell.identifier)
        
        return collectonView
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Подтвердить", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapConfirmBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(dateStackView)
        
        NSLayoutConstraint.activate([
            dateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            collectioView.heightAnchor.constraint(equalToConstant: 140),
            
            confirmBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    


}

extension SelectDateViewController {
    
    @objc func didTapConfirmBtn() {
        dismiss(animated: true)
    }
    
}

extension SelectDateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        time.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectioViewCell.identifier, for: indexPath) as! TimeCollectioViewCell
        
        cell.configure(time: time[indexPath.item])
        
        return cell
    }
    
    
}

extension SelectDateViewController: UICollectionViewDelegate {
    
}
