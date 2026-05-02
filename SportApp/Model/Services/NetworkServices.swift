//
//  NetworkServices.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 02/05/2026.
//

import Foundation

protocol NetworkServicesProtocol{
    
    func getLeagueData(sport : SportType,completion: @escaping ([League]) -> Void)
}

class NetworkServices: NetworkServicesProtocol {
    
    static let instanse : NetworkServicesProtocol = NetworkServices()
    
    private init(){}
    
    struct ApiResponse<T: Decodable>: Decodable {
        let result: [T]
    }
    
    private func getRequest<T: Decodable>(
            url: String,
            parameters: [String: Any],
            completion: @escaping ([T]?, Error?) -> Void
        ) {
//            var params = parameters
//            params["APIkey"] = apiKey
//            
//            AF.request(url, parameters: params).responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let decodedResponse = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
//                        completion(decodedResponse.result, nil)
//                    } catch {
//                        completion(nil, error)
//                    }
//                case .failure(let error):
//                    completion(nil, error)
//                }
//            }
        }
    
    func getLeagueData(sport: SportType, completion: @escaping ([League]) -> Void) {
        
      //getRequest(url: <#T##String#>, parameters: <#T##[String : Any]#>, completion: <#T##([T]?, Error?) -> Void#>)
    }
    
    
}

