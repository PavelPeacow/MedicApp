//
//  OnboardingPageViewController.swift
//  MedicApp
//
//  Created by Павел Кай on 09.03.2023.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    lazy var onboardingPage1 = OnboardingViewController(title: "Анализы", description: "Экспресс сбор и получение проб", image: UIImage(named: "test")!, pageIndex: 0)
    lazy var onboardingPage2 = OnboardingViewController(title: "Уведомления", description: "Вы быстро узнаете о результатах", image: UIImage(named: "test1")!, pageIndex: 1)
    lazy var onboardingPage3 = OnboardingViewController(title: "Мониторинг", description: "Наши врачи всегда наблюдают за вашими показателями здоровья", image: UIImage(named: "test2")!, pageIndex: 2)
    
    var currentPageIndex = 0
    
    lazy var skipBtn: UIButton = {
        let skipBtn = UIButton()
        skipBtn.setTitle("Пропустить", for: .normal)
        skipBtn.setTitleColor(.blue, for: .normal)
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        skipBtn.addTarget(self, action: #selector(didTapSkipBtn), for: .touchUpInside)
        return skipBtn
    }()
    
    lazy var pages = [onboardingPage1, onboardingPage2, onboardingPage3]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skipBtn)
        
        view.backgroundColor = .systemBackground
        setViewControllers([pages[0]], direction: .forward, animated: true)
            
        setConstraints()
        setDelegates()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    
    @objc func didTapSkipBtn() {
        navigationController?.setViewControllers([AuthViewController()], animated: true)
    }

}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingViewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingViewController), index < pages.count - 1 else { return nil }
        
        if index == 1 {
            skipBtn.setTitle("Завершить", for: .normal)
        }
        
        return pages[index + 1]
    }
    

}

extension OnboardingPageViewController: UIPageViewControllerDelegate { }

extension OnboardingPageViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            skipBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            skipBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
}
