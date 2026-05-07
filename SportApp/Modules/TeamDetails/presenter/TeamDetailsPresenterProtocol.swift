//
//  TeamDetailsPresenter.swift
//  SportApp
//
//  Created by Me3bed on 07/05/2026.
//

protocol TeamDetailsPresenterProtocol: AnyObject {
    func fetchTeamDetails()
    func filterPlayers(by segmentIndex: Int)
    func getPlayers() -> [Player]
    func getPlayersCount() -> Int
    func getPlayer(at index: Int) -> Player
    func setOutlets()
}

protocol TeamDetailsViewProtocol: AnyObject {
    func didFetchLeagues()
    func didFailWithError(_ error: String)
    func showLoading()
    func hideLoading()
}
