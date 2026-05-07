//
//  LeagueDetailsProtocol.swift
//  SportApp
//
//  Created by Me3bed on 05/05/2026.
//

protocol LeagueDetailsProtocol : AnyObject{
    func fetchLeagueEvents(
        sport : SportType,
        leagueId: Int,
        from: String,
        to: String,
        timeZone : String,
        eventType:EventStatus)
    
    func getLeagues() -> [LeagueEvent]
    func getLeaguesCount() -> Int
    func getLeague(at index: Int) -> LeagueEvent
    func getLatestLeague(at index: Int) -> LeagueEvent
    func getLatestEventCount()->Int
    func fetchTeams(leagueId: Int , sport : SportType,eventType:EventStatus)
    func getTeams() -> [Team]
    func getTeamsCount() -> Int
    func getTeam(at index: Int) -> Team
    
}

protocol LeagueEventsViewProtocol : AnyObject{
    func didFetchLeaguesEvents()
    func didFailWithError(_ error: String)
    func showLoading()
    func hideLoading()
}
