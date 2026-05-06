//
//  Team.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 05/05/2026.
//

import Foundation

struct TeamResponse: Codable {
    let result: [Team]?
}

struct Team: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    //let players: PlayerResponse?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        //case players
    }
}

