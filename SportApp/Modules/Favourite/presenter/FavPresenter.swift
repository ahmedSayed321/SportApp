//
//  FavPresenter.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import Foundation
import CoreData

class FavPresenter: FavPresnterProtocol {
    let localDataSource: LocalDataSoucreProtocol!
    private var leagues: [League] = []
    private var filteredLeagues: [League] = []
    var sport: SportType?
    
    init(localDataSource: LocalDataSoucreProtocol) {
        self.localDataSource = localDataSource
        self.leagues = localDataSource.getFavouriteLeague()
        self.filteredLeagues = self.leagues
    }

    func filterLeagues(with searchText: String) {
        if searchText.isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter {
                $0.leagueName.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }

    func getFavsCount() -> Int? {
        return filteredLeagues.count
    }

    func getLeagueAt(index: Int, sport: SportType) -> League? {
        guard index < filteredLeagues.count else { return nil }
        return filteredLeagues[index]
    }

    func deleteLeagueFromFav(leagueKey: Int) {
        localDataSource.deleteLeagueFromFav(leagueKey: leagueKey)
        self.leagues = localDataSource.getFavouriteLeague()
        self.filteredLeagues = self.leagues
    }

    func getFavouriteLeague() -> [League] {
        return filteredLeagues
    }
}

