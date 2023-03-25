//
//  LoadingViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 25.03.2023.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var timer: Timer?
    
    lazy var loadingTitle: UILabel = {
        let label = UILabel()
        label.text = "Оплата"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadingImage, loadingSubtitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 26
        return stackView
    }()
    
    lazy var loadingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loading")
        return image
    }()
    
    lazy var loadingSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Связываемся с банком..."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        animateLoading()

        view.addSubview(loadingTitle)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            loadingTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            loadingTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loadingImage.heightAnchor.constraint(equalToConstant: 66),
            loadingImage.widthAnchor.constraint(equalToConstant: 66),
        ])
    }
    
    func animateLoading() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: false)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        loadingImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }


    @objc func updateTimer(_ sender: Timer) {
        navigationController?.setViewControllers([FinalPaymentViewController()], animated: true)
    }
    
}
