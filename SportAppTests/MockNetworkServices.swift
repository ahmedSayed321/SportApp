//
//  MockNetworkServices.swift
//  SportAppTests
//
//  Created by Me3bed on 09/05/2026.
//

import Foundation
@testable import SportApp

class MockNetworkService: NetworkServicesProtocol {

    // MARK: - Stubs

    var leaguesToReturn: [League]? = nil
    var teamsToReturn: [Team]? = nil
    var playersToReturn: [Player]? = nil
    var eventsResponseToReturn: Result<LeagueEventsResponse, Error>? = nil

    // MARK: - Call trackers

    var getLeagueDataCalled = false
    var getTeamsCalled = false
    var getLeagueEventsDataCalled = false
    var getPlayersCalled = false

    // MARK: - Captured parameters

    var capturedSport: SportType?
    var capturedLeagueId: Int?
    var capturedTeamId: Int?
    var capturedFrom: String?
    var capturedTo: String?
    var capturedTimeZone: String?

    // MARK: - NetworkServicesProtocol conformance

    func getLeagueData(sport: SportType, completion: @escaping ([League]) -> Void) {
        getLeagueDataCalled = true
        capturedSport = sport
        completion(leaguesToReturn ?? [])
    }

    func getTeams(leagueId: Int, sport: SportType, completion: @escaping ([Team]) -> Void) {
        getTeamsCalled = true
        capturedLeagueId = leagueId
        capturedSport = sport
        completion(teamsToReturn ?? [])
    }

    func getLeagueEventsData(sport: SportType, leagueId: Int, from: String, to: String, timeZone: String, completion: @escaping (Result<LeagueEventsResponse, Error>) -> Void) {
        getLeagueEventsDataCalled = true
        capturedSport = sport
        capturedLeagueId = leagueId
        capturedFrom = from
        capturedTo = to
        capturedTimeZone = timeZone
        if let response = eventsResponseToReturn {
            completion(response)
        }
    }

    func getPlayers(teamId: Int, sport: SportType, completion: @escaping ([Player]) -> Void) {
        getPlayersCalled = true
        capturedTeamId = teamId
        capturedSport = sport
        completion(playersToReturn ?? [])
    }
}
