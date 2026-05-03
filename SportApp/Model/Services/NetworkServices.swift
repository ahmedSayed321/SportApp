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
}

class NetworkServices: NetworkServicesProtocol {
    
    static let instanse : NetworkServicesProtocol = NetworkServices()
    private init(){}
    private let apiKey = "d5f5ec6ad3d3f8848bff82cd403eaff46889e2aa61bc5dee3be3b4b32f12c2d3"
    
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

