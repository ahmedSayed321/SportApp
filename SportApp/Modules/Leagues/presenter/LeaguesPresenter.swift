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
    private var filteredLeagues: [League] = []
    private var isSearching: Bool = false
    
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
    
    func filterLeagues(with query: String) {
            if query.isEmpty {
                isSearching = false
                filteredLeagues = []
            } else {
                isSearching = true
                filteredLeagues = leagues.filter {
                    $0.leagueName.lowercased().contains(query.lowercased()) 
                }
            }
        DispatchQueue.main.async{
            self.view?.didFetchLeagues()
        }
        }
    
   
    func getLeagues() -> [League]   { return isSearching ? filteredLeagues : leagues }
    
    func getLeaguesCount() -> Int   { return isSearching ? filteredLeagues.count : leagues.count }
    
    func getLeague(at index: Int) -> League { return isSearching ? filteredLeagues[index] : leagues[index] }
}
