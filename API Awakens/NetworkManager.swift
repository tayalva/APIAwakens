//
//  JSONDownloader.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


class NetworkManager {
  
    
    let url = URL(string: "http://swapi.co/api/people")!
    
    func fetchData(completion: @escaping (People) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        
        if let data = data,
            
        let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []),
        let json = rawJSON as? [String: AnyObject],
        let personInfo = People(json: json){
            
    
            completion(personInfo)
          
        }
        
    }

    task.resume()
    }
}

