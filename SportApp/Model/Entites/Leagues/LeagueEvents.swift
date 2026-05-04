//
//  LeagueEvents.swift
//  SportApp
//
//  Created by Me3bed on 04/05/2026.
//

struct LeagueEventsResponse: Codable {
    let result: [LeagueEvent]?
}

struct LeagueEvent: Codable {
    let eventKey:         Int?
    let eventDate:        String?
    let eventTime:        String?
    let eventHomeTeam:    String?
    let eventAwayTeam:    String?
    let homeTeamKey:      Int?
    let awayTeamKey:      Int?
    let eventFinalResult: String?
    let eventStatus:      String?
    let homeTeamLogo:     String?
    let awayTeamLogo:     String?
    let leagueName:       String?
    let leagueKey:        Int?
    let leagueLogo:       String?

    enum CodingKeys: String, CodingKey {
        case eventKey         = "event_key"
        case eventDate        = "event_date"
        case eventTime        = "event_time"
        case eventHomeTeam    = "event_home_team"
        case eventAwayTeam    = "event_away_team"
        case homeTeamKey      = "home_team_key"
        case awayTeamKey      = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventStatus      = "event_status"
        case homeTeamLogo     = "home_team_logo"
        case awayTeamLogo     = "away_team_logo"
        case leagueName       = "league_name"
        case leagueKey        = "league_key"
        case leagueLogo       = "league_logo"
    }
}
