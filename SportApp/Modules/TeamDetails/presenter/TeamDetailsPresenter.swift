//
//  TeamDetailsPresenter.swift
//  SportApp
//
//  Created by Me3bed on 07/05/2026.
//
import Foundation
import UIKit
class TeamDetailsPresenter : TeamDetailsPresenterProtocol{
   
    weak var view: TeamDetailsViewController?
    private var teamDetails : [Player] = []
    private var filteredPlayers : [Player] = []
    private let network: NetworkServicesProtocol
    var teamLogo : String?
    var teamName : String?
    
    var teamId : Int?
    var sport : SportType?
    
    init(view: TeamDetailsViewController?, network: NetworkServicesProtocol = NetworkServices.instanse) {
        self.view = view
        self.network = network
    }
    
    func fetchTeamDetails() {
        view?.showLoading()
        network.getPlayers(teamId: teamId ?? 0, sport: sport ?? .football) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                if result.isEmpty {
                    self?.view?.didFailWithError("No players found")
                } else {
                    self?.teamDetails = result
                    self?.filterPlayers(by: 0)  // ← shows all players by default
                }
            }
        }
    }
    
    func filterPlayers(by segmentIndex: Int) {
        if segmentIndex == 0 {
            filteredPlayers = teamDetails
        } else {
            let typeMap: [Int: String] = [
                1: "Goalkeepers",
                2: "Defenders",
                3: "Midfielders",
                4: "Forwards"
            ]
            let selectedType = typeMap[segmentIndex] ?? "Goalkeepers"
            filteredPlayers = teamDetails.filter {
                ($0.playerType ?? "").caseInsensitiveCompare(selectedType) == .orderedSame
            }
        }
        view?.didFetchLeagues()
    }

    func getPlayers() -> [Player] {
        return filteredPlayers
    }
    
    func getPlayersCount() -> Int {
        return filteredPlayers.count
    }
    
    func getPlayer(at index: Int) -> Player {
        return filteredPlayers[index]
    }
    
    func setOutlets() {
        self.view?.teamName.text = self.teamName
        if let logoString = self.teamLogo, let url = URL(string: logoString) {
            self.view?.teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "messiBackground"))
        }
    }
}
