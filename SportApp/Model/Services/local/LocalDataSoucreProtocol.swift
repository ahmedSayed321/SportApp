//
//  LocalDataSoucreProtocol.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import Foundation

protocol LocalDataSoucreProtocol{
    func addLeagueToFav(league:League,sport:SportType)
    func deleteLeagueFromFav(leagueKey:Int)
    func getFavouriteLeague()->[League]
    
    
    
}
