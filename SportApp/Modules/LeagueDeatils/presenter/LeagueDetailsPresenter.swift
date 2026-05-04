//
//  LeagueDetailsPresenter.swift
//  SportApp
//
//  Created by Me3bed on 05/05/2026.
//


class LeagueDetailsPresenter : LeagueDetailsProtocol{
    weak var view : LeagueEventsViewProtocol?
    private var leaguesEvents : [LeagueEvent] = []
    private var network : NetworkServicesProtocol
    
    init(view : LeagueEventsViewProtocol, network: NetworkServicesProtocol = NetworkServices.instanse) {
        self.view = view
        self.network = network
    }
    
    
    func fetchLeagueEvents(sport: SportType, leagueId: Int, from: String, to: String, timeZone: String) {
        network.getLeagueEventsData(sport: sport, leagueId: leagueId, from: from, to: to, timeZone: timeZone) { result in
            self.view?.showLoading()
            
            switch result {
            case .success(let eventResponse):
                self.leaguesEvents = eventResponse.result!
                self.view?.hideLoading()
            case .failure(let error):
                self.view?.didFailWithError(error.localizedDescription)
            }
            
        }
    }
    
    func getLeagues() -> [LeagueEvent] {
        return leaguesEvents
    }
    
    func getLeaguesCount() -> Int {
        return leaguesEvents.count
    }
    
    func getLeague(at index: Int) -> LeagueEvent {
        return leaguesEvents[index]
    }
}

