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
    var pageIndex = 8
    
    var url: URL {
        
        switch selectedCategory {
            
        case .people: return URL(string: "http://swapi.co/api/people/?page=\(pageIndex)")!
        case .starships: return URL(string: "http://swapi.co/api/starships/?page=\(pageIndex)")!
        case .vehicles: return URL(string: "http://swapi.co/api/vehicles/?page=\(pageIndex)")!
            
        }
     
    }
    
///////////////////

    func fetchPerson(completion: @escaping ([Person]) -> Void) {
    
        let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        guard let data = data,
            let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = rawJSON as? [String: AnyObject] else {
                print("error! no json for person")
                return }
        guard let nextPage = json["next"] as? String else {
            print("there is no next page")
            return }
         print(nextPage)
        guard let results = json["results"] as? [[String: Any]] else { fatalError() }
        let people = results.flatMap { Person(json: $0) }
        completion(people)
            
            
            
    }
        task.resume()
    }
    
    
    func fetchPlanet(completion: @escaping (Planet) -> Void) {
        
        guard let url = URL(string: homePlanetURL) else {
        print("no planet!!!")
            return
        
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                
                let json = rawJson as? [String: AnyObject],
                
                let planet = Planet(json: json) {
                
                completion(planet)
                
            } else {
                
                print("Either no data was returned, or data was not serialized.")
                
            
            }
           
        }
        
        task.resume()
    }
    

/////////////////////
        
    func fetchVehicle(completion: @escaping ([Vehicle]) -> Void) {
            print(url)
            let task = URLSession.shared.dataTask(with: url) { (data,
                response, error) in
                guard let data = data,
                    let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = rawJSON as? [String: AnyObject] else {
                        print("error!")
                        return }
                
                guard let results = json["results"] as? [[String: Any]] else { fatalError() }
                let vehicle = results.flatMap { Vehicle(json: $0) }
                completion(vehicle)
            }
        task.resume()
      
    }
 /////////////////////////
        
        
        func fetchStarship(completion: @escaping ([Starship]) -> Void) {
            print(url)
            let task = URLSession.shared.dataTask(with: url) { (data,
                response, error) in
                guard let data = data,
                    let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                    let json = rawJSON as? [String: AnyObject] else {
                        print("error!")
                        return }
                
                guard let results = json["results"] as? [[String: Any]] else { fatalError() }
                let starship = results.flatMap { Starship(json: $0) }
                completion(starship)
            }
            task.resume()
        }
        


}

