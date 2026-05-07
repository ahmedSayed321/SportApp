//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by Me3bed on 06/05/2026.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var presenter: TeamDetailsPresenterProtocol?
    let indicator = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var playerSegment: UISegmentedControl!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!

    var teamNameText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        playersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")

        // --- Dark background ---
        view.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.16, alpha: 1)

        // --- Navigation Bar Appearance ---
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.16, alpha: 1)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemGreen,
            .font: UIFont.boldSystemFont(ofSize: 22)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemGreen

        title = teamNameText ?? "Team Details"

        // --- Team Name label ---
        teamName.textColor = .white

        // --- Team Logo Card Styling ---
        setupTeamImageCard()

        // --- Segmented Control Styling ---
        setupSegmentedControl()

        // --- Table View Styling ---
        playersTableView.backgroundColor = .clear
        playersTableView.separatorStyle = .none
        playersTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        // --- Loading Indicator ---
        indicator.center = view.center
        indicator.color = .white
        view.addSubview(indicator)

        presenter?.fetchTeamDetails()
        presenter?.setOutlets()
    }

    // MARK: - Setup Helpers

    private func setupTeamImageCard() {
        guard let teamImage = teamImage else { return }

        // Make image circular
        teamImage.clipsToBounds = true
        teamImage.contentMode = .scaleAspectFill
        teamImage.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1)

        // Round after layout pass so we get the real size
        teamImage.layoutIfNeeded()
        let radius = min(teamImage.bounds.width, teamImage.bounds.height) / 2
        teamImage.layer.cornerRadius = radius > 0 ? radius : 40

        // Green glow shadow on the superview card
        if let container = teamImage.superview {
            container.layer.shadowColor = UIColor.systemGreen.cgColor
            container.layer.shadowOpacity = 0.6
            container.layer.shadowOffset = CGSize(width: 0, height: 4)
            container.layer.shadowRadius = 8
            container.layer.masksToBounds = false
            container.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1)
            container.layer.cornerRadius = 16
        }
    }

    private func setupSegmentedControl() {
        // White text for unselected segments
        playerSegment.setTitleTextAttributes(
            [.foregroundColor: UIColor.white,
             .font: UIFont.systemFont(ofSize: 13, weight: .medium)],
            for: .normal
        )
        // White text for selected segment
        playerSegment.setTitleTextAttributes(
            [.foregroundColor: UIColor.white,
             .font: UIFont.systemFont(ofSize: 13, weight: .bold)],
            for: .selected
        )
        // Dark background tinted green on selected
        playerSegment.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.22, alpha: 1)
        playerSegment.selectedSegmentTintColor = UIColor.systemGreen.withAlphaComponent(0.85)

        playerSegment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        presenter?.filterPlayers(by: sender.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDelegate & DataSource

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getPlayersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        if let player = presenter?.getPlayer(at: indexPath.row) {
            cell.setOutlets(player)
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 120 }
}

// MARK: - TeamDetailsViewProtocol

extension TeamDetailsViewController: TeamDetailsViewProtocol {
    func didFetchLeagues() {
        DispatchQueue.main.async {
            self.playersTableView.reloadData()
        }
    }

    func didFailWithError(_ error: String) {
        print("❌ Error: \(error)")
    }

    func showLoading() { indicator.startAnimating() }

    func hideLoading() { indicator.stopAnimating() }
}

