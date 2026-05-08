//
//  FavouriteViewController.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import UIKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favsTable: UITableView!
    var favPresenter: FavPresnterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.textColor = .whiteText
        searchBar.searchTextField.tintColor = .systemGreen

        favsTable.delegate = self
        favsTable.dataSource = self
        favsTable.backgroundColor = .clear
        favsTable.register(
            UINib(nibName: "CustomLeagueTableViewCell", bundle: nil),
            forCellReuseIdentifier: "CustomLeagueTableViewCell"
        )

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let localDS = LocalDataSource(cxt: context)
        favPresenter = FavPresenter(localDataSource: localDS)

        NetworkMonitor.shared.startMonitoring { _ in }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationBarAppearance()
        favPresenter.filterLeagues(with: "")
        favsTable.reloadData()
    }

    private func applyNavigationBarAppearance() {
        title = "Favourites"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appPrimaryBackground
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemGreen,
            .font: UIFont.boldSystemFont(ofSize: 22)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemGreen
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPresenter.getFavsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favsTable.dequeueReusableCell(
            withIdentifier: "CustomLeagueTableViewCell",
            for: indexPath
        ) as! CustomLeagueTableViewCell

        if let league = favPresenter?.getLeagueAt(index: indexPath.row, sport: .football) {
            cell.setOutlets(league, sport: league.sportType ?? .football)
            cell.favButton.isHidden = true
        }

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favPresenter.deleteLeagueFromFav(
                leagueKey: favPresenter.getLeagueAt(
                    index: indexPath.row,
                    sport: favPresenter.sport ?? .football
                )!.leagueKey
            )
            favsTable.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard NetworkMonitor.shared.isConnected else {
            showNoInternetAlert()
            return
        }

        guard let league = favPresenter?.getLeagueAt(index: indexPath.row, sport: .football),
              let sport = league.sportType else {
            print("Missing league or sportType")
            return
        }

        let leagueDetails = storyboard?.instantiateViewController(
            identifier: "LeagueDetailsViewController"
        ) as! LeagueDetailsViewController

        leagueDetails.leagueId = league.leagueKey
        leagueDetails.sportType = sport
        navigationController?.pushViewController(leagueDetails, animated: true)
    }

    private func showNoInternetAlert() {
        let alert = NoInternetAlertView()
        alert.onRetry = { }
        alert.show(in: self.view)
    }
}

extension FavouriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        favPresenter.filterLeagues(with: searchText)
        favsTable.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        favPresenter.filterLeagues(with: "")
        favsTable.reloadData()
    }
}
