//
//  JSONDownloader.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


class NetworkManager {
  
    
    let url = URL(string: "http://swapi.co/api/people/")!
    
    func fetchData(completion: @escaping ([Person]) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        
        guard let data = data else {
            
            print("no data!")
        return
        }
        
        
        
        
        
        guard let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []) else {
            
            print("json serialization failure")
        return
        }
        guard let json = rawJSON as? [String: AnyObject] else {
            
            
            print("error 3")
            
            return
        }
        
        guard let results = json["results"] as? [[String: Any]] else { fatalError() }
        
        let people = results.flatMap { Person(json: $0) }
        
    completion(people)
        
    }

    task.resume()
    }
}

