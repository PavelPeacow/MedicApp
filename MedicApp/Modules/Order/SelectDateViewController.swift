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
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGray6
        
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
    
    func setState(isSelected: Bool) {
        if isSelected {
            timeLabel.textColor = .white
            contentView.backgroundColor = .blue
        } else {
            timeLabel.textColor = .gray
            contentView.backgroundColor = .systemGray6
        }
    }
    
}


protocol SelectDateViewControllerDelegate {
    func didTapConfirmDateBtn(_ date: String, time: String)
}


class SelectDateViewController: UIViewController {
    
    var time = ["10:00", "13:00", "14:00", "15:00", "16:00", "18:00","19:00",]
    
    var delegate: SelectDateViewControllerDelegate?
    
    var selectedTimeCell: TimeCollectioViewCell?
    
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
        date.textfield.delegate = self
        date.textfield.inputView = datePicker
        return date
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
        return picker
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
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setLayout() {
        view.layoutIfNeeded()
        selectedTimeCell = collectioView.cellForItem(at: IndexPath(item: 0, section: 0)) as? TimeCollectioViewCell
        selectedTimeCell?.setState(isSelected: true)
    }
    
    
    func formateDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
}

extension SelectDateViewController {
    
    @objc func didSelectDate(_ sender: UIDatePicker) {
        let date = sender.date
        selectDate.textfield.text = formateDate(date)
    }
    
    @objc func didTapConfirmBtn() {
        let dateStr = selectDate.textfield.text ?? ""
        let time = selectedTimeCell?.timeLabel.text ?? ""
        
        delegate?.didTapConfirmDateBtn(dateStr, time: time)
        dismiss(animated: true)
    }
    
}

extension SelectDateViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.inputView == datePicker {
            return false
        } else {
            return true
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TimeCollectioViewCell
        
        guard cell != selectedTimeCell else {
            return
        }
        selectedTimeCell?.setState(isSelected: false)
        selectedTimeCell = cell
        selectedTimeCell?.setState(isSelected: true)
    }
    
}
