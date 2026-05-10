//
//  SportAppAPITests.swift
//  SportAppTests
//
//  Created by Me3bed on 10/05/2026.
//

import XCTest
@testable import SportApp

final class SportAppAPITests: XCTestCase {

    var networkService: NetworkServicesProtocol!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServices.instanse
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    // MARK: - League Data Tests
    func testGetLeagueData_Football_ReturnsData() {
        let expectation = self.expectation(description: "Fetch Football Leagues")
        
        networkService.getLeagueData(sport: .football) { leagues in
            XCTAssertNotNil(leagues, "Leagues should not be nil")
            XCTAssertGreaterThan(leagues.count, 0, "Should return at least one league")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }

    // MARK: - League Events Tests
    func testGetLeagueEventsData_Football_ReturnsData() {
        let expectation = self.expectation(description: "Fetch League Events")
        
        networkService.getLeagueEventsData(sport: .football, leagueId: 152, from: "2024-01-01", to: "2024-01-30", timeZone: "") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.result)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10)
    }

    // MARK: - Teams Tests
    func testGetTeams_Football_ReturnsData() {
        let expectation = self.expectation(description: "Fetch Teams")
        
        networkService.getTeams(leagueId: 152, sport: .football) { teams in
            XCTAssertNotNil(teams)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }

    // MARK: - Players Tests
    func testGetPlayers_Football_ReturnsData() {
        let expectation = self.expectation(description: "Fetch Players")
        
        networkService.getPlayers(teamId: 47, sport: .football) { players in
            XCTAssertNotNil(players)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    // MARK: - Multi-Sport Checks
    func testGetLeagueData_Basketball_ReturnsData() {
        let expectation = self.expectation(description: "Fetch Basketball Leagues")
        
        networkService.getLeagueData(sport: .basketball) { leagues in
            XCTAssertNotNil(leagues)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 12)
    }
}
