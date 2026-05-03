//
//  SportType.swift
//  Top-League
//
//  Created by JETSMobileLabMini6 on 30/04/2026.
//

import Foundation

enum SportType: String {
    case football    = "football"
    case basketball  = "basketball"
    case cricket     = "cricket"
    case tennis      = "tennis"
    
 
    var baseURL: String {
        switch self {
        case .football:   return "https://apiv2.allsportsapi.com/football"
        case .basketball: return "https://apiv2.allsportsapi.com/basketball"
        case .cricket:    return "https://apiv2.allsportsapi.com/cricket"
        case .tennis:     return "https://apiv2.allsportsapi.com/tennis"
        }
    }
    
    var hasTeams: Bool {
        switch self {
        case .football, .basketball, .cricket: return true
        case .tennis:                          return false
        }
    }
    
    var scoreLabel: String {
        switch self {
        case .football:   return "Goals"
        case .basketball: return "Points"
        case .cricket:    return "Runs"
        case .tennis:     return "Sets"
        }
    }
    var displayName: String {
           return self.rawValue.capitalized
    }
    var imageName: String {
           switch self {
           case .football:   return "foot"
           case .basketball: return "basketball"
           case .cricket:    return "Cricket"
           case .tennis:     return "tennis"
           }
       }

       static var allSports: [SportType] {
           return [.football, .basketball, .cricket, .tennis]
       }
}
