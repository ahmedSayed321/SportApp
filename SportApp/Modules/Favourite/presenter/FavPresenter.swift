//
//  FavPresenter.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import Foundation
import CoreData
class FavPresenter:FavPresnterProtocol{
    let localDataSource: LocalDataSoucreProtocol!
    private var leagues: [League] = []
    var sport:SportType?
    init(localDataSource: LocalDataSoucreProtocol) {
        self.localDataSource = localDataSource
        self.leagues = localDataSource.getFavouriteLeague()
    }
        
        
        func deleteLeagueFromFav(leagueKey: Int) {
            localDataSource.deleteLeagueFromFav(leagueKey: leagueKey)
            self.leagues = localDataSource.getFavouriteLeague()
        }
        func getFavouriteLeague() -> [League] {
            return localDataSource.getFavouriteLeague()
        }
        func getFavsCount() -> Int? {
            return localDataSource.getFavouriteLeague().count
        }
        func getLeagueAt(index: Int,sport:SportType) -> League? {
            let leagues = localDataSource.getFavouriteLeague()
            guard index < leagues.count else { return nil }
            return leagues[index]
            
        }
       
        
        
        
        
        
}

