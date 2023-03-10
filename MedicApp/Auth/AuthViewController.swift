//
//  AuthViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    lazy var stackViewWelcome: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeTitle, welcomeDescription])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.text = "✋ Добро пожаловать!"
        return label
    }()
    
    lazy var welcomeDescription: UILabel = {
        let label = UILabel()
        label.text = "Войдите, чтобы пользоваться функциями приложения"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackViewAuthMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewAuth, logInBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewAuth: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textfieldLabel, emailTextfield])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var textfieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход по E-mail"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var emailTextfield: UITextField = {
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
        textField.delegate = self
        textField.addTarget(self, action: #selector(didEditingChange), for: .editingChanged)
        return textField
    }()
    
    lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .blue
        btn.setTitle("Далее", for: .normal)
        btn.addTarget(self, action: #selector(didTapLogInBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackViewYandexAuth: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yandexTitle, logInBtnYandex])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var yandexTitle: UILabel = {
        let label = UILabel()
        label.text = "Или войдите с помощью"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var logInBtnYandex: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle("Войти с Яндекс", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnState(text: nil)
        
        view.backgroundColor = .systemBackground
        view.addSubview(stackViewWelcome)
        view.addSubview(stackViewAuthMain)
        view.addSubview(stackViewYandexAuth)
        
        setConstraints()
    }
    
    private func setBtnState(text: String?) {
        guard let text = text, !text.isEmpty else {
            logInBtn.alpha = 0.5
            logInBtn.isUserInteractionEnabled = false
            return
        }
        
        logInBtn.alpha = 1
        logInBtn.isUserInteractionEnabled = true
        
    }
    
    
}

extension AuthViewController {
    
    @objc func didTapLogInBtn() {
        let vc = EmailCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func didEditingChange(_ sender: UITextField) {
        setBtnState(text: sender.text)
    }
    
}

extension AuthViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewWelcome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stackViewWelcome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewWelcome.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stackViewAuthMain.topAnchor.constraint(equalTo: stackViewWelcome.bottomAnchor, constant: 60),
            stackViewAuthMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewAuthMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logInBtn.heightAnchor.constraint(equalToConstant: 55),
            emailTextfield.heightAnchor.constraint(equalToConstant: 55),
            
            stackViewYandexAuth.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            stackViewYandexAuth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewYandexAuth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logInBtnYandex.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
    
}
