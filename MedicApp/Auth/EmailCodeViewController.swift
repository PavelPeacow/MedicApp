//
//  EmailCodeViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class EmailCodeViewController: UIViewController {
    
    var timer: Timer?
    var counter = 5
    
    var enteredCode = "" {
        willSet {
            if newValue == needCode {
                navigationController?.setViewControllers([CreatePasswordViewController()], animated: true)
            }
        }
    }
    var needCode = "1111"
    
    lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTitle, stackViewTextfields, tryAgainLabel, tryAgainBtn])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 29
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var emailTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Введите код из E-mail"
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackViewTextfields: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldFirstNumber, textFieldSecondNumber, textFieldThridNumber, textFieldFourthNumber])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var textFieldFirstNumber: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    lazy var textFieldSecondNumber: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    lazy var textFieldThridNumber: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    lazy var textFieldFourthNumber: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = .systemGray6
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    lazy var tryAgainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Отправить код повторно можно будет через 5 секунд"
        return label
    }()
    
    lazy var tryAgainBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Отправить заново", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(didTapTryAgainBtn), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        view.backgroundColor = .systemBackground
        
        view.addSubview(stackViewMain)
        setConstraints()
        addTargets()
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
    
    func getNextTextfield(textField: UITextField) {
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
    
    func getPreviousTextfield(textField: UITextField) {
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
    
}

extension EmailCodeViewController {
    
    @objc func updateTimer() {
        if counter > 0 {
            counter -= 1
            tryAgainLabel.text = "Отправить код повторно можно будет через \(counter) секунд"
        } else {
            timer?.invalidate()
            UIView.animate(withDuration: 0.15) {
                self.tryAgainBtn.isHidden = false
                self.tryAgainLabel.isHidden = true
            }
            
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
            enteredCode.removeLast()
            return
        }
        enteredCode.append(text)
        getNextTextfield(textField: sender)
    }

}

extension EmailCodeViewController {
    
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
