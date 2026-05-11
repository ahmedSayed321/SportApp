//
//  CustomOnboarding.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 02/05/2026.
//

import UIKit

class CustomOnboarding: UIView {
    @IBOutlet weak var onBoardingTitle: UILabel!
    @IBOutlet weak var onBoradingImage: UIImageView!
    @IBOutlet weak var onBoardingButton: UIButton?

    var onNextTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let nib = UINib(nibName: "CustomOnboarding", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    @IBAction func onBoardingBtn(_ sender: Any) {
        onNextTapped?()
    }

    func setOutlets(_ item: OnboardingItem, isLastPage: Bool = false) {
        onBoardingTitle.numberOfLines = 0
        onBoardingTitle.text = "\(item.title)\n\n\(item.description)"
        onBoradingImage.image = UIImage(named: item.image) ?? UIImage(systemName: "sportscourt")
        let buttonTitle = isLastPage ? "Get Started" : "Next"
        onBoardingButton?.setTitle(buttonTitle, for: .normal)
       
        
    }
}

struct OnboardingItem {
    let title: String
    let description: String
    let image: String
}
