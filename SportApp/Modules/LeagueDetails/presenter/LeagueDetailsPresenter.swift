//
//  LeagueDetailsPresenter.swift
//  SportApp
//
//  Created by Me3bed on 05/05/2026.
//
import Foundation

class LeagueDetailsPresenter : LeagueDetailsProtocol{
            
    weak var view : LeagueEventsViewProtocol?
    private var leaguesEvents : [LeagueEvent] = []
    private var latestleaguesEvents : [LeagueEvent] = []
    private var teamsList : [Team] = []
    private var network : NetworkServicesProtocol
    
    init(view : LeagueEventsViewProtocol, network: NetworkServicesProtocol = NetworkServices.instanse) {
        self.view = view
        self.network = network
    }
    
    
    func fetchLeagueEvents(sport: SportType, leagueId: Int, from: String, to: String, timeZone: String,eventType:EventStatus) {
        
        view?.showLoading()
        
        network.getLeagueEventsData(sport: sport, leagueId: leagueId, from: from, to: to, timeZone: timeZone) { result in
            
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch eventType{
                case .upComing:
                    switch result{
                    case .success(let eventResponse):
                        self.leaguesEvents = eventResponse.result ?? []
                        self.view?.didFetchLeaguesEvents()
                        
                    case .failure(let error):
                        self.view?.didFailWithError(error.localizedDescription)
                    }
                case .latest:
                    switch result{
                    case .success(let eventResponse):
                        self.latestleaguesEvents = eventResponse.result ?? []
                        self.view?.didFetchLeaguesEvents()
                        
               case .failure(let error):
                        self.view?.didFailWithError(error.localizedDescription)
                    }
                default :
                    print("")
                
        
            }
                
            }
        }
    }
    func fetchTeams(leagueId: Int, sport: SportType,eventType:EventStatus) {
        view?.showLoading()
        print("teamslist = ",teamsList.count)
        network.getTeams(leagueId: leagueId, sport: sport) {[weak self]  result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch eventType{
                case .teams:
                    if result.isEmpty{
                        self?.teamsList=[]
                        
                        print("teamslist = ",self?.teamsList.count)
                    }else{
                        self?.teamsList=result
                        self?.view?.didFetchLeaguesEvents()
                        print("teamslist = ",self?.teamsList.count)
                    }
                default :
                    print("default")
                
                
        
               }
                
            }
            
        }
    }
    
    func getTeams() -> [Team] {
        return teamsList
    
    }
    
    func getTeamsCount() -> Int {
        return teamsList.count
    }
    
    func getTeam(at index: Int) -> Team {
      return teamsList[index]
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
    func getLatestEventCount() -> Int {
        return latestleaguesEvents.count
    }
    func getLatestLeague(at index: Int) -> LeagueEvent {
        return latestleaguesEvents[index]
    }
}
enum EventStatus{
    case upComing
    case latest
    case teams
}

