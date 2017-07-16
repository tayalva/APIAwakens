//
//  JSONDownloader.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


class NetworkManager {
    
    
    var url: URL {
        
        switch selectedCategory {
            
        case .people: return URL(string: "http://swapi.co/api/people/")!
        case .starships: return URL(string: "http://swapi.co/api/starships/")!
        case .vehicles: return URL(string: "http://swapi.co/api/vehicles/")!
            
        }
    }

    func fetchData(completion: @escaping ([Any]) -> Void) {
        print(url)
    let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        
        guard let data = data,
            let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = rawJSON as? [String: AnyObject] else {
                print("error!")
                return
        }
        guard let results = json["results"] as? [[String: Any]] else { fatalError() }
        
        switch selectedCategory {
            
        case .people:
        let people = results.flatMap { Person(json: $0) }
            completion(people)
    
            
            
        case .starships:
            
            let starships = results.flatMap { Starship(json: $0) }
            completion(starships)
            
        case .vehicles:
            
            let vehicles = results.flatMap { Vehicle(json: $0) }
            completion(vehicles)
            
        }
        
    }

    task.resume()
    }
}

