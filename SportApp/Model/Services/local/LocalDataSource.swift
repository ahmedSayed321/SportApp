//
//  LocalDataSource.swift
//  SportApp
//
//  Created by AndrewMagdy on 07/05/2026.
//

import Foundation
import CoreData
class LocalDataSource:LocalDataSoucreProtocol{
    
    
    var appCxt:NSManagedObjectContext
    
    init(cxt:NSManagedObjectContext){
        self.appCxt=cxt
    }
    func addLeagueToFav(league: League,sport:SportType) {
        let entity=NSEntityDescription.entity(forEntityName: "LocalLeague", in: appCxt)
        let favLeague=NSManagedObject(entity: entity!, insertInto: appCxt)
        favLeague.setValue(league.leagueKey, forKey: "leagueKey")
        favLeague.setValue(league.countryName, forKey: "countryName")
        favLeague.setValue(league.leagueName, forKey: "leagueName")
        favLeague.setValue(league.countryKey, forKey: "countryKey")
        favLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favLeague.setValue(league.countryLogo, forKey: "countryLogo")
        favLeague.setValue(league.leagueSurface, forKey: "leagueSurface")
        favLeague.setValue(sport.rawValue,      forKey: "sportType")
        
        do {
            try self.appCxt.save()
            print("Saved successfully")
            
        }catch{
            print(error.localizedDescription)
        }
    }
    func deleteLeagueFromFav(leagueKey: Int) {
        let fetchReq:NSFetchRequest<NSManagedObject>=NSFetchRequest(entityName: "LocalLeague")
        fetchReq.predicate=NSPredicate(format: "leagueKey == %d", leagueKey)
        do{
            let result = try self.appCxt.fetch(fetchReq)
            for obj in result{
                appCxt.delete(obj)
            }
            try appCxt.save()
            print("Deleted successfully")
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    func getFavouriteLeague() -> [League] {
        var leagueArray=[League]()
        let fetchReq:NSFetchRequest<NSManagedObject>=NSFetchRequest(entityName: "LocalLeague")
        do{
            let result = try self.appCxt.fetch(fetchReq)
            for obj in result{
                let sportRaw = obj.value(forKey: "sportType") as? String ?? "football"
                let league=League(
                    leagueKey: obj.value(forKey: "leagueKey") as? Int ?? 0,
                    leagueName: obj.value(forKey: "leagueName") as? String ?? "",
                    countryKey: obj.value(forKey: "countryKey") as? Int,
                    countryName: obj.value(forKey: "countryName") as? String,
                    leagueLogo: obj.value(forKey: "leagueLogo") as? String,
                    countryLogo: obj.value(forKey: "countryLogo") as? String,
                    leagueYear: obj.value(forKey: "leagueYear") as? String,
                    leagueSurface: obj.value(forKey: "leagueSurface") as? String,
                    sportType:    SportType(rawValue: sportRaw) ?? .football
                )
                leagueArray.append(league)
                
            }
            print("Data retuned successfuly successfully")
        }catch{
            print(error.localizedDescription)
        }
        return leagueArray
        
    }
   
    
    
    
}
