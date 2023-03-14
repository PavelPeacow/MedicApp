//
//  AuthViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private lazy var stackViewWelcome: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeTitle, welcomeDescription])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var welcomeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.text = "✋ Добро пожаловать!"
        return label
    }()
    
    private lazy var welcomeDescription: UILabel = {
        let label = UILabel()
        label.text = "Войдите, чтобы пользоваться функциями приложения"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackViewAuthMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewAuth, logInBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewAuth: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textfieldLabel, emailTextfield])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textfieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход по E-mail"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var emailTextfield: InputTextfield = {
        let textField = InputTextfield(placeholder: "example@mail.ru", keyboardType: .emailAddress)
        textField.delegate = self
        textField.addTarget(self, action: #selector(didEditingChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .blue
        btn.setTitle("Далее", for: .normal)
        btn.addTarget(self, action: #selector(didTapLogInBtn), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackViewYandexAuth: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yandexTitle, logInBtnYandex])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var yandexTitle: UILabel = {
        let label = UILabel()
        label.text = "Или войдите с помощью"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var logInBtnYandex: UIButton = {
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
    
    func validateEmail(_ email: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: "^[A-Za-z0-9]+@[A-Za-z0-9]+\\.[a-z]{2,}$") else { return false }
        if let _ = regex.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) {
            return true
        }
        return false
    }
    
    
}

private extension AuthViewController {
    
    @objc func didTapLogInBtn() {
        if validateEmail(emailTextfield.text ?? "") {
            let vc = EmailCodeViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("no")
        }
        
    }
    
    @objc func didEditingChange(_ sender: UITextField) {
        setBtnState(text: sender.text)
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

private extension AuthViewController {
    
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
