//
//  OrderViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 21.03.2023.
//

import UIKit
import BottomSheet

class OrderViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var orderTitle: UILabel = {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressTextfield, timeTextfield])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var addressTextfield: InputTextfieldWithTitle = {
        let adress = InputTextfieldWithTitle(title: "Адрес", placeholder: "Адрес")
        adress.textfield.delegate = self
        return adress
    }()
    
    lazy var timeTextfield: InputTextfieldWithTitle = {
        let time = InputTextfieldWithTitle(title: "Дата и время", placeholder: "Дата и время")
        time.textfield.delegate = self
        return time
    }()
    
    lazy var pacientStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pacientTextfield, addPacientBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var pacientTextfield = InputTextfieldWithTitle(title: "Кто будет сдавать анализы? *", placeholder: "Пациент")
    
    lazy var addPacientBtn: UIButton = {
        let btn = UIButton()
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("Добавить еще пациента", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var numAndTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberTextfield, titleAndTextViewStackView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var numberTextfield = InputTextfieldWithTitle(title: "Телефон", placeholder: "Телефон")
    
    lazy var titleAndTextViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleWithMicroStackView, commentTextView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleWithMicroStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textViewLabel, addCommentBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var textViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Комментарий"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var addCommentBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "micro"), for: .normal)
        return btn
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        return textView
    }()
    

    lazy var promocodesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promocodesOneStackView, promocodesSecondStackView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var promocodesOneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promoOneLabel, nextImageView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var promoOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Оплата Apple Pay"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "goNext")
        return imageView
    }()
    
    lazy var promocodesSecondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promoSecondLabel, nextImageSecondView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var promoSecondLabel: UILabel = {
        let label = UILabel()
        label.text = "Промокод"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    lazy var nextImageSecondView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "goNext")
        return imageView
    }()
    
    lazy var itogWithBtnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itogStackView, orderBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var itogStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [analizCount, analizPrice])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var analizCount: UILabel = {
        let label = UILabel()
        label.text = "1 анализ"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    lazy var analizPrice: UILabel = {
        let label = UILabel()
        label.text = "690 ₽"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    lazy var orderBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .blue
        btn.setTitle("Заказать", for: .normal)
        btn.addTarget(self, action: #selector(didTapOrderBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        view.backgroundColor = .systemBackground

        scrollView.addSubview(orderTitle)
        scrollView.addSubview(inputStackView)
        
        scrollView.addSubview(pacientStackView)
        
        scrollView.addSubview(numAndTextStackView)
        
        scrollView.addSubview(promocodesStackView)
        
        scrollView.addSubview(itogWithBtnStackView)
        
        getSavedAdress()
        getSavedPerson()
        
        setConstraints()
    }
    
    func configure(analizCount: String, price: String) {
        self.analizCount.text = "\(analizCount) анализ"
        analizPrice.text = price
    }
    
    func getSavedAdress() {
        let adress = UserDefaults.standard.string(forKey: KeychainManager.keys.adresskey)
        let flatNumber = UserDefaults.standard.string(forKey: KeychainManager.keys.flatKey)
       
        
        if let adress = adress, let flatNumber = flatNumber {
            addressTextfield.textfield.text = " \(adress), кв. \(flatNumber)"
        }
    }
    
    func getSavedPerson() {
        let surname = UserDefaults.standard.string(forKey: KeychainManager.keys.surnameKey)
        let name = UserDefaults.standard.string(forKey: KeychainManager.keys.nameKey)
        let gender = UserDefaults.standard.string(forKey: KeychainManager.keys.sexKey)
        
        if let surname = surname, let name = name, let gender = gender {
            pacientTextfield.textfield.text = "\(gender == "Мужской" ? "🧔" : "👩‍🦰") \(surname) \(name)"
        }
    }
    
}

extension OrderViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressTextfield.textfield {
            textField.resignFirstResponder()
            let vc = AdressViewController()
            vc.delegate = self
            vc.preferredContentSize = .init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width + 200)
            presentBottomSheet(viewController: vc, configuration: .init(cornerRadius: 12, pullBarConfiguration: .hidden, shadowConfiguration: .default))
        } else if textField == timeTextfield.textfield {
            textField.resignFirstResponder()
            let vc = SelectDateViewController()
            vc.delegate = self
            vc.setLayout()
            vc.preferredContentSize = .init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width + 200)
            presentBottomSheet(viewController: vc, configuration: .init(cornerRadius: 12, pullBarConfiguration: .hidden, shadowConfiguration: .default))
        }
    }
    
}

extension OrderViewController: AdressViewControllerDelegate {
    
    func didEnterAdress(_ adress: String) {
        addressTextfield.textfield.text = adress
    }
    
}

extension OrderViewController: SelectDateViewControllerDelegate {
    
    func didTapConfirmDateBtn(_ date: String, time: String) {
        timeTextfield.textfield.text = "\(date) \(time)"
    }
    
}

extension OrderViewController {
    
    @objc func didTapOrderBtn() {
        let vc = LoadingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.setViewControllers([vc], animated: true)
    }
    
}

extension OrderViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: itogWithBtnStackView.bottomAnchor, constant: 15),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            orderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            orderTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            inputStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            inputStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            inputStackView.topAnchor.constraint(equalTo: orderTitle.bottomAnchor, constant: 32),
            
            pacientStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pacientStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pacientStackView.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 32),
            
            addPacientBtn.heightAnchor.constraint(equalToConstant: 50),
            
            numAndTextStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            numAndTextStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            numAndTextStackView.topAnchor.constraint(equalTo: pacientStackView.bottomAnchor, constant: 32),
            
            commentTextView.widthAnchor.constraint(equalTo: numAndTextStackView.widthAnchor),
            commentTextView.heightAnchor.constraint(equalToConstant: 140),
            
            promocodesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            promocodesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            promocodesStackView.topAnchor.constraint(equalTo: numAndTextStackView.bottomAnchor, constant: 55),
            
            nextImageView.heightAnchor.constraint(equalToConstant: 20),
            nextImageView.widthAnchor.constraint(equalToConstant: 20),
            
            nextImageSecondView.heightAnchor.constraint(equalToConstant: 20),
            nextImageSecondView.widthAnchor.constraint(equalToConstant: 20),
            
            itogWithBtnStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itogWithBtnStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            itogWithBtnStackView.topAnchor.constraint(equalTo: promocodesStackView.bottomAnchor, constant: 30),
            
            orderBtn.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
}
