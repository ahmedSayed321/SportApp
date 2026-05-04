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
        timeZone : String)
    
    func getLeagues() -> [LeagueEvent]
    func getLeaguesCount() -> Int
    func getLeague(at index: Int) -> LeagueEvent
}

protocol LeagueEventsViewProtocol : AnyObject{
    func didFetchLeaguesEvents()
    func didFailWithError(_ error: String)
    func showLoading()
    func hideLoading()
}
