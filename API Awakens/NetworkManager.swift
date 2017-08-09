//
//  JSONDownloader.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation



class NetworkManager {
    
    
    var jsonResults = [""]
    var pageIndex = 1
    var itemCount = 0
    var itemCountStarships = 0
    var peopleArray: [Person] = []
    var vehicleArray: [Vehicle] = []
    var starshipArray: [Starship] = []
    var associatedVehiclesArray: [Vehicle] = []
    var associatedStarshipsArray: [Starship] = []
    
    var url: URL {
        
        switch selectedCategory {
            
        case .people: return URL(string: "http://swapi.co/api/people/?page=\(pageIndex)")!
        case .starships: return URL(string: "http://swapi.co/api/starships/?page=\(pageIndex)")!
        case .vehicles: return URL(string: "http://swapi.co/api/vehicles/?page=\(pageIndex)")!
            
        }
     
    }
    
    
    var vehicleUrlArray: [String] = []
    
    var vehicleUrl: String {
        
        var result: String = ""
        for x in vehicleUrlArray {
            
            result = x
            
        }
        
       return result
        
    }
    
    var starshipUrlArray: [String] = []
    
    var starshipUrl: String {
        
        var result: String = ""
        for x in starshipUrlArray {
            
            result = x
            
        }
        
        return result
        
    }
    
    
///////////////////

    func fetchPerson(completion: @escaping ([Person]?, StarWarsError?) -> Void) {
        
       
        
        let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        guard let data = data,
            let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = rawJSON as? [String: AnyObject] else {
             
                completion(nil, .networkError)
                return }
        
           let nextPage = json["next"] as? String
           guard let results = json["results"] as? [[String: Any]] else {
            print("no results to show")
            return }
            
            
        let people = results.flatMap { Person(json: $0) }
    
            self.peopleArray += people
            self.pageIndex += 1
            
            
            
            if nextPage != nil {
            
                self.fetchPerson(completion: completion)
                
                
             } else {
        
            self.pageIndex = 1
            
            self.peopleArray.noDuplicates()
                
                completion(self.peopleArray, nil)
                }

            
    }
        
        task.resume()
            
            

    
    }
    
    
    func fetchPlanet(completion: @escaping (Planet?, StarWarsError?) -> Void) {
        
        guard let url = URL(string: homePlanetURL) else {
        
            completion(nil, .noPlanet)
            return
        
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                
                let json = rawJson as? [String: AnyObject],
                
                let planet = Planet(json: json) {
                
                completion(planet, nil)
                
            } else {
                
                print("Either no data was returned, or data was not serialized.")
                
                completion(nil, .noPlanet)
                
            
            }
           
        }
        
        task.resume()
    }
    

/////////////////////
        
    func fetchVehicle(completion: @escaping ([Vehicle]?, StarWarsError?) -> Void) {
        
            let task = URLSession.shared.dataTask(with: url) { (data,
                response, error) in
                guard let data = data,
                    let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = rawJSON as? [String: AnyObject] else {
                        completion(nil, .networkError)
                        return }
                let nextPage = json["next"] as? String
                guard let results = json["results"] as? [[String: Any]] else { fatalError() }
                let vehicle = results.flatMap { Vehicle(json: $0) }
                
                self.vehicleArray += vehicle
                self.pageIndex += 1
                
                if nextPage != nil {
                    
                    self.fetchVehicle(completion: completion)
                } else {
                    
                    
                    self.pageIndex = 1
                
                    self.vehicleArray.noDuplicates()
                
                    completion(self.vehicleArray, nil)
                    
                }
                
            }
        
        task.resume()
      
    }
 /////////////////////////
        
        
        func fetchStarship(completion: @escaping ([Starship]?, StarWarsError?) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { (data,
                response, error) in
                guard let data = data,
                    let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = rawJSON as? [String: AnyObject] else {
                        completion(nil, .networkError)
                        return }
                let nextPage = json["next"] as? String
                guard let results = json["results"] as? [[String: Any]] else { fatalError() }
                let starship = results.flatMap { Starship(json: $0) }
                
                self.starshipArray += starship
                self.pageIndex += 1
                if nextPage != nil {
                    
                    self.fetchStarship(completion: completion)
                    
                }else {
                    
                    self.pageIndex = 1
                
                self.starshipArray.noDuplicates()
                  
                completion(self.starshipArray, nil)
                    
                }
            }
            task.resume()
        }
    
    
    func fetchPersonVehicles(completion: @escaping ([Vehicle]) -> Void) {
        guard let url = URL(string: vehicleUrlArray[itemCount]) else {
            print("no vehicle association")
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                let json = rawJson as? [String: AnyObject],
                let vehicle = Vehicle(json: json) else {
                
                print("Either no data was returned, or data was not serialized.")
                    return
            }
            self.associatedVehiclesArray += [vehicle]
            self.itemCount -= 1
            if self.itemCount != -1 {
                
                self.fetchPersonVehicles(completion: completion)
            } else {
                
              
                completion(self.associatedVehiclesArray)
            }
        
        }
        
          task.resume()
        
    }
    
    func fetchPersonStarships(completion: @escaping ([Starship]?) -> Void) {
        guard let url = URL(string: starshipUrlArray[itemCountStarships]) else {
            print("no vehicle association")
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                let json = rawJson as? [String: AnyObject],
                let starship = Starship(json: json) else {
                    
                    print("Either no data was returned, or data was not serialized.")
                    return
            }
            self.associatedStarshipsArray += [starship]
            self.itemCountStarships -= 1
            if self.itemCountStarships != -1 {
                
                self.fetchPersonStarships(completion: completion)
            } else {
                
                
                completion(self.associatedStarshipsArray)
            }
            
        }
        
        task.resume()
        
    }
        


}

