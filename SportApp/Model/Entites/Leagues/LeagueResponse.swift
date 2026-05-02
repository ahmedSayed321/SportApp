//
//  LeagueResponse.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 02/05/2026.
//


import Foundation

struct LeagueResponse: Codable {
    let result: [League]
}

struct League: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    let leagueYear: String?
    let leagueSurface: String?
    
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case leagueYear = "league_year"
        case leagueSurface = "league_surface"
    }
}
