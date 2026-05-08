//
//  FavPresnterProtocol.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import Foundation
protocol FavPresnterProtocol{
    func deleteLeagueFromFav(leagueKey:Int)
    func getFavouriteLeague()->[League]
    func getFavsCount()->Int?
    func getLeagueAt(index:Int,sport:SportType)->League?
    var sport: SportType? { get }
    func filterLeagues(with searchText: String)
}
