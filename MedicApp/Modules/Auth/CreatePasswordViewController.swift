//
//  CreatePasswordViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit
import Security

enum PasswordState {
    case skipedPassword
    case alreadyCreated
}

class CreatePasswordViewController: UIViewController {
    
    private var numberButtons: [UIButton] = []
    private var dots = [UIView]()
    private var password = "" {
        willSet {
            if newValue.count == 4 {
                print(newValue)
                switch state {
                    
                case .skipedPassword:
                    savePasswordToKeyChain(password: newValue)
                    navigationController?.setViewControllers([CreatePatientViewController()], animated: true)
                    
                case .alreadyCreated:
                    let savedPasswordData = KeychainManager.default.get(key: KeychainManager.keys.passwordKey)
                    let password = String(data: savedPasswordData ?? .init(), encoding: .utf8) ?? ""
                    print(password)
                    if password == newValue {
                        navigationController?.setViewControllers([MainTabBarViewController()], animated: true)
                    } else {
                        print("wrong")
                    }
                }
               
            }
        }
    }
    
    var state: PasswordState = .skipedPassword {
        willSet {
            if newValue == .alreadyCreated {
                passwordTitle.text = "Введите пароль"
                passwordDescription.isHidden = true
                skipBtn.isHidden = true
            }
        }
    }
    
    private lazy var stackViewDescription: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTitle, passwordDescription])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Создайте пароль"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Для защиты ваших персональных данных"
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
                                    
    private lazy var stackViewDots: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Пропустить", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(didTapSkipBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(skipBtn)
        view.addSubview(stackViewDescription)
        view.addSubview(stackViewDots)
        view.addSubview(stackViewMain)
        
        createDots()
        createButtons()
        setConstraints()
    }
    
    func setPasswordState(state: PasswordState) {
        self.state = state
        print(state)
    }
    
    private func createDots() {
        for _ in 0..<4 {
            let view = UIView()
            view.layoutSubviews()
            view.layer.cornerRadius = 8
            view.layer.borderColor = UIColor.systemBlue.cgColor
            view.layer.borderWidth = 1
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 16),
                view.widthAnchor.constraint(equalToConstant: 16),
            ])
            
            dots.append(view)
            stackViewDots.addArrangedSubview(view)
            
        }
    }
    
    private func createButtons() {
        for row in 0..<4 {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .equalSpacing
            rowStackView.spacing = 10
            
            if row == 3 {
                let spacerView = UIView()
                
                let button = UIButton(type: .system)
                button.setTitle("0", for: .normal)
                button.backgroundColor = .systemGray6
                button.setTitleColor(.black, for: .normal)
                button.layer.cornerRadius = 40
                button.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
                                
                let buttonDelete = UIButton(type: .system)
                buttonDelete.setImage(UIImage(named: "deleteKey")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
                buttonDelete.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
                
                NSLayoutConstraint.activate([
                    spacerView.heightAnchor.constraint(equalToConstant: 80),
                    spacerView.widthAnchor.constraint(equalToConstant: 80),
                    
                    button.heightAnchor.constraint(equalToConstant: 80),
                    button.widthAnchor.constraint(equalToConstant: 80),
                    
                    buttonDelete.heightAnchor.constraint(equalToConstant: 80),
                    buttonDelete.widthAnchor.constraint(equalToConstant: 80),
                ])
                
                numberButtons.append(button)
                rowStackView.addArrangedSubview(spacerView)
                rowStackView.addArrangedSubview(button)
                rowStackView.addArrangedSubview(buttonDelete)
                
                stackViewMain.addArrangedSubview(rowStackView)
                
                return
            }
            
            for col in 0..<3 {
                let index = row * 3 + col
                let button = UIButton(type: .system)
                button.setTitle("\(index + 1)", for: .normal)
                button.backgroundColor = .systemGray6
                button.setTitleColor(.black, for: .normal)
                button.layer.cornerRadius = 40
                button.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
                
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: 80),
                    button.widthAnchor.constraint(equalToConstant: 80),
                ])
                
                numberButtons.append(button)
                rowStackView.addArrangedSubview(button)
            }
            
            stackViewMain.addArrangedSubview(rowStackView)
        }
    }
    
    private func savePasswordToKeyChain(password: String) {
        KeychainManager.default.add(key: KeychainManager.keys.passwordKey, data: password.data(using: .utf8) ?? Data())
    }
    
}

private extension CreatePasswordViewController {
    
    @objc func numberButtonPressed(_ sender: UIButton) {
        guard password.count < 4 else { return }
        guard let number = sender.title(for: .normal) else { return }
        
        password.append(number)
        print(state)
        let index = password.count - 1
        let dot = dots[index]
        dot.backgroundColor = .systemBlue
        
        UIView.animate(withDuration: 0.05) {
            sender.backgroundColor = .systemBlue
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                sender.backgroundColor = .systemGray6
            }
        }

    }
    
    @objc func didTapDeleteButton() {
        guard !password.isEmpty else { return }
        
        let index = password.count - 1
        print(index)
        let dot = dots[index]
        dot.backgroundColor = .white
        
        password.removeLast()
    }
    
    @objc func didTapSkipBtn() {
        KeychainManager.default.add(key: KeychainManager.keys.passwordKey, data: "skip".data(using: .utf8) ?? Data())
        navigationController?.setViewControllers([CreatePatientViewController()], animated: true)
    }
    
}

private extension CreatePasswordViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            skipBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            skipBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackViewDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewDescription.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            stackViewDots.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewDots.topAnchor.constraint(equalTo: stackViewDescription.bottomAnchor, constant: 60),
            
            stackViewMain.topAnchor.constraint(lessThanOrEqualTo: stackViewDots.bottomAnchor, constant: 60),
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackViewMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
    
}
