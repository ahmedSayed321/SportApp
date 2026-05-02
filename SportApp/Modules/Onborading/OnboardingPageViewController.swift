import UIKit

class OnboardingPageViewController: UIViewController {
    let onboardingItem: OnboardingItem
    let isLastPage: Bool
    let pageIndex: Int
    var onNextTapped: (() -> Void)?

    init(onboardingItem: OnboardingItem, pageIndex: Int, isLastPage: Bool) {
        self.onboardingItem = onboardingItem
        self.pageIndex = pageIndex
        self.isLastPage = isLastPage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let onboardingView = CustomOnboarding(frame: .zero)
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        onboardingView.setOutlets(onboardingItem, isLastPage: isLastPage)
        onboardingView.onNextTapped = { [weak self] in
            self?.onNextTapped?()
        }

        view.addSubview(onboardingView)
        NSLayoutConstraint.activate([
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
