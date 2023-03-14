//
//  OnboardingViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    lazy var stackViewContent: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainTitle, mainDescription])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(title: String, description: String, image: UIImage, pageIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        pageControl.currentPage = pageIndex
        configure(title: title, description: description, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pageControl)

        view.addSubview(stackViewContent)
        view.addSubview(mainImage)
        
        setConstraints()
    }
    
    func configure(title: String, description: String, image: UIImage) {
        mainTitle.text = title
        mainDescription.text = description
        mainImage.image = image
    }
    
}

extension OnboardingViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewContent.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            stackViewContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackViewContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            pageControl.topAnchor.constraint(equalTo: stackViewContent.bottomAnchor, constant: 50),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
   
    
}
