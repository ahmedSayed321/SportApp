//
//  LeaguesPresenter.swift
//  SportApp
//
//  Created by AndrewMagdy on 02/05/2026.
//

import Foundation
import Foundation

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    private var leagues: [League] = []
    private let network: NetworkServicesProtocol
    
    init(view: LeaguesViewProtocol, network: NetworkServicesProtocol = NetworkServices.instanse) {
        self.view = view
        self.network = network
    }
    
    func fetchLeagues(for sport: SportType) {
        view?.showLoading()
        
        network.getLeagueData(sport: sport) { [weak self] leagues in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                if leagues.isEmpty {
                    self?.view?.didFailWithError("No leagues found")
                } else {
                    self?.leagues = leagues
                    self?.view?.didFetchLeagues()
                }
            }
        }
    }
    
    func getLeagues() -> [League]   { return leagues }
    func getLeaguesCount() -> Int   { return leagues.count }
    func getLeague(at index: Int) -> League { return leagues[index] }
}
