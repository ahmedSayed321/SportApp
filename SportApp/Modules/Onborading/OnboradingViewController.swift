//
//  OnboradingViewController.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 02/05/2026.
//

import UIKit

class OnboradingViewController: UIPageViewController {

    private lazy var items: [OnboardingItem] = [
        OnboardingItem(title: "Welcome to Remontada App", description: "Your hub for live scores, top leagues, and real-time updates.", image: "messiBackground"),
        OnboardingItem(title: "Learn Your Favorite Sports", description: "Get live updates, favorite leagues, and custom sport content.", image: "LebronBackground"),
        OnboardingItem(title: "Ready to Play", description: "Tap Get Started to move into the app and enjoy the experience.", image: "CarlosBackground")
    ]

    private var pages: [OnboardingPageViewController] = []
    var finishHandler: (() -> Void)?

    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .systemBackground
        setupPages()
        
        

        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        }
    }

    private func setupPages() {
        pages = items.enumerated().map { index, item in
            let page = OnboardingPageViewController(onboardingItem: item, pageIndex: index, isLastPage: index == items.count - 1)
            page.onNextTapped = { [weak self, weak page] in
                guard let self = self else { return }
                self.goToNextPage(from: page)
            }
            return page
        }
    }

    private func goToNextPage(from currentPage: OnboardingPageViewController?) {
        guard let currentPage = currentPage,
              let currentIndex = pages.firstIndex(where: { $0 === currentPage }) else {
            return
        }

        let nextIndex = currentIndex + 1
        if nextIndex < pages.count {
            let nextPage = pages[nextIndex]
            setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        } else {
            finishHandler?()
        }
    }
}

extension OnboradingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? OnboardingPageViewController,
              let index = pages.firstIndex(where: { $0 === current }),
              index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? OnboardingPageViewController,
              let index = pages.firstIndex(where: { $0 === current }),
              index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}
