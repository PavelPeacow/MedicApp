//
//  MedicAppTests.swift
//  MedicAppTests
//
//  Created by Павел Кай on 22.03.2023.
//

import XCTest
@testable import MedicApp

final class MedicAppTests: XCTestCase {
    
    class SamplePageViewController {
        var page1 = OnboardingViewController(title: "page1", description: "test11", image: UIImage(named: "test")!, pageIndex: 0)
        var page2 = OnboardingViewController(title: "page2", description: "test22", image: UIImage(named: "test1")!, pageIndex: 1)
        var page3 = OnboardingViewController(title: "page3", description: "test33", image: UIImage(named: "test2")!, pageIndex: 2)
        
        var btnTitle = "Пропустить"
        
        var didFinishOnboarding = false

        lazy var pages = [OnboardingViewController]()
        lazy var currentPageIndex = 0
        
        init() {
            pages = createPages()
        }
        
        private func createPages() -> [OnboardingViewController] {
            [page1, page2, page3]
        }
        
        func getCurrentPage() -> OnboardingViewController {
            pages[currentPageIndex]
        }

        func moveToNextPage() {
            guard let index = pages.firstIndex(of: getCurrentPage()), index < pages.count - 1 else { return }
            currentPageIndex = index + 1
            if currentPageIndex == 2 {
                btnTitle = "Завершить"
            }
        }
        
        func moveToPreviousPage() {
            guard let index = pages.firstIndex(of: getCurrentPage()), index > 0 else { return }
            currentPageIndex = index - 1
        }
        
        func tapBtn() {
            didFinishOnboarding = true
        }
        
    }
    
    /// Проверка извлечения при перемещении вправо
    func testSlideRight() throws {
        let pageController = SamplePageViewController()

        pageController.moveToNextPage()
        pageController.moveToNextPage()
        
        let currentPage = pageController.getCurrentPage()
        XCTAssert(currentPage.mainTitle.text == "page3")
    }
    
    
    /// Проверка извлечения при перемещении влево
    func testSlideLeft() throws {
        let pageController = SamplePageViewController()
        pageController.currentPageIndex = 2
        
        pageController.moveToPreviousPage()
        pageController.moveToPreviousPage()
        
        let currentPage = pageController.getCurrentPage()
        XCTAssert(currentPage.mainTitle.text == "page1")
    }
    
    /// Проверка надписи кнопки
    func testBtnTitleWhenLastPageLeft() throws {
        let pageController = SamplePageViewController()
        
        pageController.moveToNextPage()
        pageController.moveToNextPage()
        
        XCTAssert(pageController.btnTitle == "Завершить")
    }
    
    ///Проверка на флаг
    func testOnboardingFinish() throws {
        let pageController = SamplePageViewController()
        
        pageController.tapBtn()
        
        let didFinishOnboarding = pageController.didFinishOnboarding
        print(didFinishOnboarding)
        XCTAssert(didFinishOnboarding)
    }

}
