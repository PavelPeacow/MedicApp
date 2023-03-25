//
//  AdressViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 22.03.2023.
//

import UIKit

protocol AdressViewControllerDelegate {
    func didEnterAdress(_ adress: String)
}

class AdressViewController: UIViewController {
    
    var isSaveOn = false
    
    var delegate: AdressViewControllerDelegate?
    
    lazy var adressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressAndBtnStackView, adress, coordionateStackView,
                                                       flatStackView, domofon, switchStackView, saveName, confirmBtn])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var addressAndBtnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [adressTitle, mapBtn])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var adressTitle: UILabel = {
        let label = UILabel()
        label.text = "Адрес сдачи анализов"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var mapBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "map")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var adress = InputTextfieldWithTitle(title: "Ваш адресс")
    
    lazy var coordionateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dolgota, shitota, visota])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var dolgota = InputTextfieldWithTitle(title: "Долгота")
    lazy var shitota = InputTextfieldWithTitle(title: "Широта")
    lazy var visota = InputTextfieldWithTitle(title: "Высота")
    
    lazy var flatStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [flat, podezd, etaj])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var flat = InputTextfieldWithTitle(title: "Квартира")
    lazy var podezd = InputTextfieldWithTitle(title: "Подъезд")
    lazy var etaj = InputTextfieldWithTitle(title: "Этаж")
    
    lazy var domofon = InputTextfieldWithTitle(title: "Домофон")
        
    lazy var switchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [switchTitle, saveSwitch])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var switchTitle: UILabel = {
        let label = UILabel()
        label.text = "Сохранить этот адрес?"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var saveSwitch: UISwitch = {
        let swit = UISwitch()
        swit.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
        return swit
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Подтвердить", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapConfirmBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveName = InputTextfieldWithTitle(placeholder: "Название: например дом, работа")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSavedAdress()

        saveName.isHidden = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(adressStackView)
        
        setConstraints()
    }
    

    func getSavedAdress() {
        adress.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.adresskey) ?? .init(), encoding: .utf8)
        dolgota.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.dolgotaKey) ?? .init(), encoding: .utf8)
        shitota.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.shirotaKey) ?? .init(), encoding: .utf8)
        visota.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.visotaKey) ?? .init(), encoding: .utf8)
        flat.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.flatKey) ?? .init(), encoding: .utf8)
        podezd.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.podezdKey) ?? .init(), encoding: .utf8)
        etaj.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.etajKey) ?? .init(), encoding: .utf8)
        domofon.textfield.text = String(data: KeychainManager.default.get(key: KeychainManager.keys.domofonKey) ?? .init(), encoding: .utf8)
    }
    

}

extension AdressViewController {
    
    @objc func didTapConfirmBtn() {
        let adress = "\(adress.textfield.text!), кв. \(flat.textfield.text!)"
        delegate?.didEnterAdress(adress)
        
        if isSaveOn {
            KeychainManager.default.saveAdress(adress: self.adress.textfield.text ?? "",
                                               dolgota: dolgota.textfield.text ?? "",
                                               shirota: shitota.textfield.text ?? "",
                                               visota: visota.textfield.text ?? "",
                                               flat: flat.textfield.text ?? "",
                                               podezd: podezd.textfield.text ?? "",
                                               etaj: etaj.textfield.text ?? "",
                                               domofon: domofon.textfield.text ?? "",
                                               nameAdress: saveName.textfield.text ?? "")
            
            print("saveOn")
            dismiss(animated: true)
        } else {
            print("ok")
            dismiss(animated: true)
        }
    }
    
    @objc func didSwitch(_ sender: UISwitch) {
        if sender.isOn {
            isSaveOn = true
            saveName.isHidden = false
        } else {
            isSaveOn = false
            saveName.isHidden = true
        }
    }
    
}

extension AdressViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            adressStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            adressStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            adressStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            mapBtn.heightAnchor.constraint(equalToConstant: 24),
            mapBtn.widthAnchor.constraint(equalToConstant: 24),
            
            dolgota.widthAnchor.constraint(equalToConstant: 130),
            shitota.widthAnchor.constraint(equalToConstant: 130),
            
            etaj.widthAnchor.constraint(equalToConstant: 100),
            
            confirmBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}
