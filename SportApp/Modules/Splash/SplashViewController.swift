//
//  SplashViewController.swift
//  SportApp
//
//  Created by Me3bed on 03/05/2026.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    // MARK: - UI Elements

    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "football")
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    private let appNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 48)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.alpha = 0
        return lbl
    }()

    // MARK: - Properties

    /// Called when all splash animations finish — used by SceneDelegate to navigate forward.
    var onAnimationFinished: (() -> Void)?

    private let fullName = "Remontada"
    private var logoInitialCenterY: CGFloat = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runSplashAnimation()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = UIColor(
            red: 26/255,
            green: 26/255,
            blue: 46/255,
            alpha: 1
        )
        view.addSubview(animationView)
        view.addSubview(appNameLabel)

        NSLayoutConstraint.activate([
            // Logo: centered horizontally, slightly above center vertically
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor),

            // App name label: below the logo
            appNameLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 10),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }

    // MARK: - Animations

    // MARK: - Animations

    private func runSplashAnimation() {
        // Start: image is shifted upward and fully transparent
        animationView.transform = CGAffineTransform(translationX: 0, y: -view.bounds.height)
        animationView.alpha = 0

        // Fade in while drifting down to its final position
        UIView.animate(
            withDuration: 1.1,
            delay: 0.0,
            options: .curveEaseOut
        ) {
            self.animationView.transform = .identity   // drifts back to center
            self.animationView.alpha = 1               // fades in
        } completion: { _ in
            // Step 2: Netflix-style text reveal after logo settles
            self.animateNetflixText()
        }
    }

    /// Reveals "Remontada" Netflix-style:
    /// "R" appears with a bold scale-flash, then the remaining letters
    /// type themselves in one by one.
    private func animateNetflixText() {
        let firstLetter = String(fullName.prefix(1))   // "R"
        let restLetters = String(fullName.dropFirst())  // "emontada"

        // --- Phase A: Show only "R" with a scale-in flash ---
        appNameLabel.text = firstLetter
        appNameLabel.transform = CGAffineTransform(scaleX: 1.45, y: 1.45)
        appNameLabel.alpha = 0

        UIView.animate(
            withDuration: 0.4,
            delay: 0.15,          // slight pause after the image settles
            options: .curveEaseOut
        ) {
            self.appNameLabel.alpha = 1
            self.appNameLabel.transform = .identity
        } completion: { _ in
            // --- Phase B: Type out each remaining letter ---
            self.typeLetters(Array(restLetters), into: firstLetter, delay: 0.08)
        }
    }
    /// Recursively appends one character at a time to the label with a slight fade-in.
    /// When all letters are done, fires `onAnimationFinished` after a short pause.
    private func typeLetters(_ letters: [Character], into current: String, delay: TimeInterval) {
        guard !letters.isEmpty else {
            // All letters typed — wait a beat then hand off
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.onAnimationFinished?()
            }
            return
        }

        var remaining = letters
        let nextChar = remaining.removeFirst()
        let newText = current + String(nextChar)

        // Tiny delay before each letter
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.transition(
                with: self.appNameLabel,
                duration: 0.12,
                options: .transitionCrossDissolve
            ) {
                self.appNameLabel.text = newText
            } completion: { _ in
                self.typeLetters(remaining, into: newText, delay: delay)
            }
        }
    }
}
