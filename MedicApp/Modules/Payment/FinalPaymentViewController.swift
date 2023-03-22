//
//  FinalPaymentViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 22.03.2023.
//

import UIKit
import SafariServices

class FinalPaymentViewController: UIViewController {
    
    lazy var finalTitlePage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Оплата"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var finalImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "test")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [finalTitle, finalSubtitle, finalDescription])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var finalTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Ваш заказ успешно оплачен!"
        label.textColor = .green
        return label
    }()
    
    lazy var finalSubtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Вам осталось дождаться приезда медсестры и сдать анализы. До скорой встречи!"
        label.textColor = .gray
        return label
    }()
    
    lazy var finalDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Не забудьте ознакомиться с правилами подготовки к сдаче анализов"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLink))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gesture)
        label.textColor = .gray
        return label
    }()
    
    lazy var stackViewBtn: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn, mainBtn])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    lazy var checkBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Чек покупки", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    lazy var mainBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("На главную", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapMainBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainText = "Не забудьте ознакомиться с правилами подготовки к сдаче анализов"
        let str = "правилами подготовки к сдаче анализов"
        
        let attrString = NSMutableAttributedString(string: mainText)
        let linkRange = (mainText as NSString).range(of: str)
        print(linkRange)
        attrString.addAttributes([.foregroundColor : UIColor.blue], range: linkRange)
        
        finalDescription.attributedText = attrString
        
        view.backgroundColor = .systemBackground

        view.addSubview(finalTitlePage)
        view.addSubview(finalImage)
        view.addSubview(stackView)
        view.addSubview(stackViewBtn)
        
        NSLayoutConstraint.activate([
            
            finalTitlePage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            finalTitlePage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            finalTitlePage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            finalImage.topAnchor.constraint(equalTo: finalTitlePage.bottomAnchor, constant: 65),
            finalImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -25),
            finalImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 25),
        
            stackView.topAnchor.constraint(equalTo: finalImage.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            stackViewBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            stackViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            checkBtn.heightAnchor.constraint(equalToConstant: 55),
            mainBtn.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
}

extension FinalPaymentViewController {
    
    @objc func didTapLink() {
        guard let url = URL(string: "https://medic.madskill.ru/avatar/prav.pdf") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapMainBtn() {
        navigationController?.setViewControllers([HomeViewController()], animated: true)
    }
    
}
