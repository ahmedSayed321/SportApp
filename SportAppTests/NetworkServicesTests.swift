//
//  NetworkServicesTests.swift
//  SportAppTests
//
//  Created by Me3bed on 09/05/2026.
//

import XCTest
@testable import SportApp

final class NetworkServicesTests: XCTestCase {

    var sut: MockNetworkService!

    let mockPlayer = Player(
        playerKey: 1,
        playerImage: "img_url",
        playerName: "Messi",
        playerNumber: "10",
        playerCountry: "Argentina",
        playerType: "Forward",
        playerAge: "36",
        playerMatchPlayed: "100",
        playerGoals: "800",
        playerYellowCards: "2",
        playerRedCards: "0",
        playerInjured: "No",
        playerSubstituteOut: "5",
        playerSubstitutesOnBench: "0",
        playerAssists: "300",
        playerBirthdate: "1987",
        playerIsCaptain: "Yes",
        playerShotsTotal: "5000",
        playerGoalsConceded: "0",
        playerFoulsCommitted: "100",
        playerTackles: "50",
        playerBlocks: "10",
        playerCrossesTotal: "200",
        playerInterceptions: "30",
        playerClearances: "20",
        playerDispossesed: "100",
        playerSaves: "0",
        playerInsideBoxSaves: "0",
        playerDuelsTotal: "500",
        playerDuelsWon: "300",
        playerDribbleAttempts: "1000",
        playerDribbleSucc: "700",
        playerPenComm: "0",
        playerPenWon: "50",
        playerPenScored: "100",
        playerPenMissed: "10",
        playerPasses: "10000",
        playerPassesAccuracy: "90%",
        playerKeyPasses: "500",
        playerWoordworks: "20",
        playerRating: "9.5"
    )

    override func setUp() {
        super.setUp()
        sut = MockNetworkService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - getLeagueData

    func test_getLeagueData_isCalled_withCorrectSport() {
        sut.getLeagueData(sport: .football) { _ in }

        XCTAssertTrue(sut.getLeagueDataCalled)
        XCTAssertEqual(sut.capturedSport, .football)
    }

    func test_getLeagueData_returnsLeagues_onSuccess() {
        let expected = [
            League(
                leagueKey: 1,
                leagueName: "Premier League",
                countryKey: nil,
                countryName: "England",
                leagueLogo: nil,
                countryLogo: nil,
                leagueYear: nil,
                leagueSurface: nil,
                sportType: .football
            )
        ]
        sut.leaguesToReturn = expected

        var result: [League]?
        sut.getLeagueData(sport: .football) { leagues in
            result = leagues
        }

        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.leagueName, "Premier League")
    }

    func test_getLeagueData_returnsEmpty_whenNoData() {
        sut.leaguesToReturn = nil

        var result: [League]?
        sut.getLeagueData(sport: .basketball) { leagues in
            result = leagues
        }

        XCTAssertTrue(result?.isEmpty == true)
    }

    // MARK: - getLeagueEventsData

    func test_getLeagueEventsData_isCalled_withCorrectParameters() {
        sut.getLeagueEventsData(sport: .football, leagueId: 152, from: "2024-01-01", to: "2024-01-31", timeZone: "GMT") { _ in }

        XCTAssertTrue(sut.getLeagueEventsDataCalled)
        XCTAssertEqual(sut.capturedSport, .football)
        XCTAssertEqual(sut.capturedLeagueId, 152)
        XCTAssertEqual(sut.capturedFrom, "2024-01-01")
        XCTAssertEqual(sut.capturedTo, "2024-01-31")
        XCTAssertEqual(sut.capturedTimeZone, "GMT")
    }

    func test_getLeagueEventsData_returnsEvents_onSuccess() {
        let mockResponse = LeagueEventsResponse(result: [])
        sut.eventsResponseToReturn = .success(mockResponse)

        var receivedResult: Result<LeagueEventsResponse, Error>?
        sut.getLeagueEventsData(sport: .cricket, leagueId: 10, from: "2024-01-01", to: "2024-12-31", timeZone: "GMT") { result in
            receivedResult = result
        }

        XCTAssertNotNil(receivedResult)
        if case .success(let response) = receivedResult {
            XCTAssertNotNil(response)
        } else {
            XCTFail("Expected success but got failure or nil")
        }
    }

    func test_getLeagueEventsData_returnsError_onFailure() {
        let expectedError = NSError(domain: "network", code: 500)
        sut.eventsResponseToReturn = .failure(expectedError)

        var receivedError: Error?
        sut.getLeagueEventsData(sport: .tennis, leagueId: 1, from: "2024-01-01", to: "2024-12-31", timeZone: "GMT") { result in
            if case .failure(let error) = result {
                receivedError = error
            }
        }

        XCTAssertNotNil(receivedError)
    }

    // MARK: - getTeams

    func test_getTeams_isCalled_withCorrectParameters() {
        sut.getTeams(leagueId: 207, sport: .football) { _ in }

        XCTAssertTrue(sut.getTeamsCalled)
        XCTAssertEqual(sut.capturedLeagueId, 207)
        XCTAssertEqual(sut.capturedSport, .football)
    }

    func test_getTeams_returnsTeams_onSuccess() {
        let expected = [Team(teamKey: 55, teamName: "team", teamLogo: "logo", players: nil)]
        sut.teamsToReturn = expected

        var result: [Team]?
        sut.getTeams(leagueId: 55, sport: .football) { teams in
            result = teams
        }

        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.teamName, "team")
    }

    func test_getTeams_returnsEmpty_whenNoData() {
        sut.teamsToReturn = nil

        var result: [Team]?
        sut.getTeams(leagueId: 207, sport: .basketball) { teams in
            result = teams
        }

        XCTAssertTrue(result?.isEmpty == true)
    }

    // MARK: - getPlayers

    func test_getPlayers_isCalled_withCorrectParameters() {
        sut.getPlayers(teamId: 152, sport: .football) { _ in }

        XCTAssertTrue(sut.getPlayersCalled)
        XCTAssertEqual(sut.capturedTeamId, 152)
        XCTAssertEqual(sut.capturedSport, .football)
    }

    func test_getPlayers_returnsPlayers_onSuccess() {
        sut.playersToReturn = [mockPlayer]

        var result: [Player]?
        sut.getPlayers(teamId: 152, sport: .football) { players in
            result = players
        }

        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.playerName, "Messi")
        XCTAssertEqual(result?.first?.playerKey, 1)
    }

    func test_getPlayers_returnsEmpty_whenNoData() {
        sut.playersToReturn = nil

        var result: [Player]?
        sut.getPlayers(teamId: 99, sport: .cricket) { players in
            result = players
        }

        XCTAssertTrue(result?.isEmpty == true)
    }
}
