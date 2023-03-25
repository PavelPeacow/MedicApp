//
//  CreatePatientViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 10.03.2023.
//

import UIKit

class CreatePatientViewController: UIViewController {
    
    private let sexes = ["Мужской", "Женский"]
    
    private lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewTitleAndBtn, mainDescription, additionalDescription, stackViewInput])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewTitleAndBtn: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardTitle, skipBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Создание карты пациента"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Пропустить", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Без карты пациента вы не сможете заказать анализы."
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var additionalDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "В картах пациентов будут храниться результаты анализов вас и ваших близких."
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var stackViewInput: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextfield, secondNameTextfield, surnameTextfield, birthDateTextfield, sexTextfield, logInBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameTextfield: InputTextfield = {
        let textField = InputTextfield(placeholder: "Имя")
        return textField
    }()
    
    private lazy var secondNameTextfield: InputTextfield = {
        let textField = InputTextfield(placeholder: "Фамилия")
        return textField
    }()
    
    private lazy var surnameTextfield: InputTextfield = {
        let textField = InputTextfield(placeholder: "Отчество")
        return textField
    }()
    
    private lazy var birthDateTextfield: UITextField = {
        let textField = InputTextfield(placeholder: "Дата рождения")
        textField.inputView = datePicker
        textField.delegate = self
        return textField
    }()
    
    private lazy var sexTextfield: InputTextfield = {
        let textField = InputTextfield(placeholder: "Пол")
        textField.inputView = pciker
        textField.delegate = self
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
    
    private lazy var pciker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(didTapCreateBtn), for: .touchUpInside)
        btn.setTitle("Создать", for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPacientCard()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackViewDescription)
        setConstraints()
    }
    
    func savePacientCard() {
        KeychainManager.default.add(key: KeychainManager.keys.nameKey, data: nameTextfield.text?.data(using: .utf8) ?? .init())
        KeychainManager.default.add(key: KeychainManager.keys.secondKey, data: secondNameTextfield.text?.data(using: .utf8) ?? .init())
        KeychainManager.default.add(key: KeychainManager.keys.surnameKey, data: surnameTextfield.text?.data(using: .utf8) ?? .init())
        KeychainManager.default.add(key: KeychainManager.keys.birthKey, data: birthDateTextfield.text?.data(using: .utf8) ?? .init())
        KeychainManager.default.add(key: KeychainManager.keys.sexKey, data: sexTextfield.text?.data(using: .utf8) ?? .init())
    }
    
    func getPacientCard() {
        nameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.nameKey) ?? .init(), encoding: .utf8)
        secondNameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.secondKey) ?? .init(), encoding: .utf8)
        surnameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.surnameKey) ?? .init(), encoding: .utf8)
        birthDateTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.birthKey) ?? .init(), encoding: .utf8)
        sexTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.sexKey) ?? .init(), encoding: .utf8)
    }
    
    
}

extension CreatePatientViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.inputView == pciker || textField.inputView == datePicker {
            return false
        } else {
            return true
        }
    }
    
}

extension CreatePatientViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sexes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        sexes[row]
    }
    
    
}

extension CreatePatientViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextfield.text = sexes[row]
        sexTextfield.resignFirstResponder()
    }
    
}

private extension CreatePatientViewController {
    
    @objc func didTapCreateBtn() {
        savePacientCard()
        navigationController?.setViewControllers([MainTabBarViewController()], animated: true)
    }
    
    @objc func didEnterDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.dateStyle = .medium
        birthDateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
}


private extension CreatePatientViewController {
    
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
