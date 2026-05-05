//
//  FootbalLeaguesProtocol.swift
//  SportApp
//
//  Created by AndrewMagdy on 02/05/2026.
//

import Foundation
protocol LeaguesPresenterProtocol: AnyObject {
    func fetchLeagues(for sport: SportType)
    func getLeagues() -> [League]
    func getLeaguesCount() -> Int
    func getLeague(at index: Int) -> League
    func filterLeagues(with query: String)
    
}

protocol LeaguesViewProtocol: AnyObject {
    func didFetchLeagues()
    func didFailWithError(_ error: String)
    func showLoading()
    func hideLoading()
}
