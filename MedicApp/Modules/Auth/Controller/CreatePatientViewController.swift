//
//  CreatePatientViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class CreatePatientViewController: UIViewController {
    
    lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewTitleAndBtn, mainDescription, additionalDescription, stackViewInput])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewTitleAndBtn: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardTitle, skipBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Создание карты пациента"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Пропустить", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Без карты пациента вы не сможете заказать анализы."
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var additionalDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "В картах пациентов будут храниться результаты анализов вас и ваших близких."
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    lazy var stackViewInput: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextfield, secondNameTextfield, surnameTextfield, birthDateTextfield, sexTextfield, logInBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@mail.ru"
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var secondNameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@mail.ru"
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var surnameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@mail.ru"
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var birthDateTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@mail.ru"
        textField.inputView = datePicker
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var sexTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@mail.ru"
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.timeZone = .current
        picker.addTarget(self, action: #selector(didEnterDate), for: .valueChanged)
        return picker
    }()
    
    lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .blue
        btn.setTitle("Создать", for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackViewDescription)
        setConstraints()
    }
    
    
}

extension CreatePatientViewController {
    
    @objc func didEnterDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.dateStyle = .medium
        birthDateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
}


extension CreatePatientViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewDescription.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            skipBtn.widthAnchor.constraint(equalToConstant: 100),
            
            nameTextfield.heightAnchor.constraint(equalToConstant: 55),
            secondNameTextfield.heightAnchor.constraint(equalToConstant: 55),
            surnameTextfield.heightAnchor.constraint(equalToConstant: 55),
            birthDateTextfield.heightAnchor.constraint(equalToConstant: 55),
            sexTextfield.heightAnchor.constraint(equalToConstant: 55),
            logInBtn.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
}
