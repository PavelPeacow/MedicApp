//
//  PacientCardViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 21.03.2023.
//

import UIKit

class PacientCardViewController: UIViewController {
    
    var sexes = ["Мужской", "Женский"]
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var scrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardDescription, cardSomeDescription])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.text = "Карта пациента"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imageProfile")
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        image.addGestureRecognizer(gesture)
        return image
    }()
    
    lazy var cardDescription: UILabel = {
        let label = UILabel()
        label.text = "Без карты пациента вы не сможете заказать анализы."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var cardSomeDescription: UILabel = {
        let label = UILabel()
        label.text = "В картах пациентов будут храниться результаты анализов вас и ваших близких."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
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
        btn.addTarget(self, action: #selector(didTapSaveBtn), for: .touchUpInside)
        btn.setTitle("Сохранить", for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPacientCard()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        
        scrollContainer.addSubview(cardTitle)
        scrollContainer.addSubview(cardImage)
        scrollContainer.addSubview(stackViewDescription)
        scrollContainer.addSubview(stackViewInput)
        
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
        print(String(data: KeychainManager.default.get(key: KeychainManager.keys.nameKey) ?? .init(), encoding: .utf8))
        nameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.nameKey) ?? .init(), encoding: .utf8)
        secondNameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.secondKey) ?? .init(), encoding: .utf8)
        surnameTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.surnameKey) ?? .init(), encoding: .utf8)
        birthDateTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.birthKey) ?? .init(), encoding: .utf8)
        sexTextfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.sexKey) ?? .init(), encoding: .utf8)
    }

    
}

extension PacientCardViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.inputView == pciker || textField.inputView == datePicker {
            return false
        } else {
            return true
        }
    }
    
}

extension PacientCardViewController: UIPickerViewDataSource {
    
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

extension PacientCardViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextfield.text = sexes[row]
        sexTextfield.resignFirstResponder()
    }
    
}

extension PacientCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        cardImage.image = UIImage(named: "test")
        
        dismiss(animated: true)
    }
    
}

private extension PacientCardViewController {
    
    @objc func didTapImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @objc func didTapSaveBtn() {
        savePacientCard()
    }
    
    @objc func didEnterDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.dateStyle = .medium
        birthDateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
}

extension PacientCardViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackViewInput.bottomAnchor, constant: 25),
            
            scrollContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            scrollContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            cardTitle.topAnchor.constraint(equalTo: scrollContainer.safeAreaLayoutGuide.topAnchor, constant: 5),
            cardTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardImage.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 8),
            cardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardImage.heightAnchor.constraint(equalToConstant: 120),
            cardImage.widthAnchor.constraint(equalToConstant: 140),
            
            stackViewDescription.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 8),
            stackViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stackViewInput.topAnchor.constraint(equalTo: stackViewDescription.bottomAnchor, constant: 8),
            stackViewInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextfield.heightAnchor.constraint(equalToConstant: 55),
            secondNameTextfield.heightAnchor.constraint(equalToConstant: 55),
            surnameTextfield.heightAnchor.constraint(equalToConstant: 55),
            birthDateTextfield.heightAnchor.constraint(equalToConstant: 55),
            sexTextfield.heightAnchor.constraint(equalToConstant: 55),
            logInBtn.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
}
