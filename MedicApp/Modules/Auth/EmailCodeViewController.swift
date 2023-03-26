//
//  EmailCodeViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class EmailCodeViewController: UIViewController {
    
    private var timer: Timer?
    private var counter = 1 {
        didSet {
            tryAgainLabel.text = "Отправить код повторно можно будет через \(counter) секунд"
        }
    }
    
    private var needCode: String?
    
    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTitle, stackViewTextfields, tryAgainLabel, tryAgainBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 29
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var emailTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Введите код из E-mail"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackViewTextfields: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldFirstNumber, textFieldSecondNumber, textFieldThridNumber, textFieldFourthNumber])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var textFieldFirstNumber: UITextField = {
        let textField = EmailCodeTextfield()
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldSecondNumber: UITextField = {
        let textField = EmailCodeTextfield()
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldThridNumber: UITextField = {
        let textField = EmailCodeTextfield()
        textField.delegate = self
        return textField
    }()
    
    private lazy var textFieldFourthNumber: EmailCodeTextfield = {
        let textField = EmailCodeTextfield()
        textField.delegate = self
        return textField
    }()
    
    private lazy var tryAgainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Отправить код повторно можно будет через 5 секунд"
        return label
    }()
    
    private lazy var tryAgainBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Отправить заново", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(didTapTryAgainBtn), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { _, _ in
            print("yes")
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackViewMain)
        setConstraints()
        addTargets()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func addTargets() {
        textFieldFirstNumber.addTarget(self, action: #selector(didEnterNumber), for: .editingChanged)
        textFieldSecondNumber.addTarget(self, action: #selector(didEnterNumber), for: .editingChanged)
        textFieldThridNumber.addTarget(self, action: #selector(didEnterNumber), for: .editingChanged)
        textFieldFourthNumber.addTarget(self, action: #selector(didEnterNumber), for: .editingChanged)
    }
    
    private func getEnterdCode() -> String {
        [textFieldFirstNumber, textFieldSecondNumber, textFieldThridNumber, textFieldFourthNumber]
            .reduce(into: "", { $0.append($1.text ?? "") })
    }
    
    private func getNextTextfield(textField: UITextField) {
        if textField == textFieldFirstNumber {
            textFieldSecondNumber.becomeFirstResponder()
        } else if textField == textFieldSecondNumber {
            textFieldThridNumber.becomeFirstResponder()
        } else if textField == textFieldThridNumber {
            textFieldFourthNumber.becomeFirstResponder()
        } else {
            return
        }
    }
    
    private func getPreviousTextfield(textField: UITextField) {
        if textField == textFieldFourthNumber {
            textFieldThridNumber.becomeFirstResponder()
        } else if textField == textFieldThridNumber {
            textFieldSecondNumber.becomeFirstResponder()
        } else if textField == textFieldSecondNumber {
            textFieldFirstNumber.becomeFirstResponder()
        } else {
            return
        }
    }
    
    func createRandomCode() -> String {
        String((0..<4).map { _ in "0123456789".randomElement()! })
    }
    
    func createNotification() {
        let code = createRandomCode()
        needCode = code
        
        let content = UNMutableNotificationContent()
        content.badge = 1
        content.title = "Code"
        content.subtitle = code
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "lol", content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error displaying notification: \(error.localizedDescription)")
            }
        }
    }
    
}

extension EmailCodeViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
}

private extension EmailCodeViewController {
    
    @objc func updateTimer() {
        if counter > 0 {
            counter -= 1
            //            tryAgainLabel.text = "Отправить код повторно можно будет через \(counter) секунд"
        } else {
            counter = 15
            //            tryAgainLabel.text = "Отправить код повторно можно будет через \(counter) секунд"
            print("che")
            createNotification()
        }
    }
    
    @objc func didTapTryAgainBtn() {
        counter = 5
        tryAgainLabel.text = "Отправить код повторно можно будет через \(counter) секунд"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        tryAgainBtn.isHidden = true
        tryAgainLabel.isHidden = false
        print("again")
    }
    
}

extension EmailCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
        return newLength <= 1
    }
    
    @objc func didEnterNumber(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else {
            getPreviousTextfield(textField: sender)
            return
        }
        
        if getEnterdCode() == needCode {
            
            let vc = CreatePasswordViewController()
            
            if let password = UserDefaults.standard.string(forKey: KeychainManager.keys.passwordKey) {
                print(password)
                
                if password == "skip" {
                    vc.setPasswordState(state: .skipedPassword)
                } else {
                    vc.setPasswordState(state: .alreadyCreated)
                }
                
            } else {
                vc.setPasswordState(state: .skipedPassword)
            }
            
            navigationController?.setViewControllers([vc], animated: true)
            
        }
        getNextTextfield(textField: sender)
    }
    
}

private extension EmailCodeViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewMain.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            textFieldFirstNumber.heightAnchor.constraint(equalToConstant: 48),
            
            textFieldSecondNumber.heightAnchor.constraint(equalToConstant: 48),
            
            textFieldThridNumber.heightAnchor.constraint(equalToConstant: 48),
            
            textFieldFourthNumber.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
}
