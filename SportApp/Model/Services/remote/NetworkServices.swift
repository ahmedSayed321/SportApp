//
//  NetworkServices.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 02/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServicesProtocol{
    
    func getLeagueData(sport : SportType,completion: @escaping ([League]) -> Void)
    func getLeagueEventsData(
        sport : SportType,
        leagueId: Int,
        from : String,
        to : String,
        timeZone : String,
        completion: @escaping (Result<LeagueEventsResponse, Error>) -> Void
    )
    func getTeams(leagueId : Int,sport : SportType , completion: @escaping ([Team]) -> Void)
        
        func getPlayers(teamId : Int,sport : SportType , completion: @escaping ([Player]) -> Void)
}

class NetworkServices: NetworkServicesProtocol {
    static let instanse : NetworkServicesProtocol = NetworkServices()
    private init(){}
    private let apiKey = "d5f5ec6ad3d3f8848bff82cd403eaff46889e2aa61bc5dee3be3b4b32f12c2d3"
    func getTeams(leagueId: Int, sport: SportType, completion: @escaping ([Team]) -> Void) {
            let params: Parameters = [
                "met"    : "Teams",
                "APIkey" : apiKey,
                "leagueId" : leagueId,
                
            ]
            print("Aalamooooooooooooooo")
            AF.request(sport.baseURL, parameters: params)
                   .responseDecodable(of: TeamResponse.self) { response in
                       switch response.result {
                       case .success(let eventsResponse):
                           completion(eventsResponse.result ?? [])
                       case .failure(_):
                           completion([])
                       }
                   }
        }
        
        func getPlayers(teamId: Int, sport: SportType , completion: @escaping ([Player]) -> Void) {
            let params: Parameters = [
                "met"    : "Players",
                "APIkey" : apiKey,
                "teamId" : teamId,
            ]
            
            AF.request(sport.baseURL, parameters: params)
                   .responseDecodable(of: PlayerResponse.self) { response in
                       switch response.result {
                       case .success(let eventsResponse):
                           completion(eventsResponse.result ?? [])
                       case .failure(let error):
                           completion([])
                       }
                   }
        }
   
    
   
    
   
    
    func getLeagueData(sport: SportType, completion: @escaping ([League]) -> Void) {
           let params: Parameters = [
               "met"    : "Leagues",
               "APIkey" : apiKey
           ]
           
           AF.request(sport.baseURL, parameters: params)
               .responseDecodable(of: LeagueResponse.self) { response in
                   switch response.result {
                   case .success(let leagueResponse):
                       completion(leagueResponse.result)
                   case .failure(let error):
                      
                       completion([])
                   }
               }
       }
    
    
    func getLeagueEventsData(sport : SportType,leagueId: Int, from: String, to: String,timeZone : String, completion: @escaping (Result<LeagueEventsResponse, any Error>) -> Void) {
        let params: Parameters = [
            "met"    : "Fixtures",
            "APIkey" : apiKey,
            "from" : from,
            "to" : to,
            "leagueId" : leagueId,
            "timezone" : timeZone
        ]
        
        AF.request(sport.baseURL, parameters: params)
               .responseDecodable(of: LeagueEventsResponse.self) { response in
                   switch response.result {
                   case .success(let eventsResponse):
                       completion(.success(eventsResponse))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
        
        
    }
    
    
    
    
    
}





//    private func getRequest<T: Decodable>(
//            url: String,
//            parameters: [String: Any],
//            completion: @escaping ([T]?, Error?) -> Void
//        ) {
////            var params = parameters
////            params["APIkey"] = apiKey
////
////            AF.request(url, parameters: params).responseData { response in
////                switch response.result {
////                case .success(let data):
////                    do {
////                        let decodedResponse = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
////                        completion(decodedResponse.result, nil)
////                    } catch {
////                        completion(nil, error)
////                    }
////                case .failure(let error):
////                    completion(nil, error)
////                }
////            }
//        }

