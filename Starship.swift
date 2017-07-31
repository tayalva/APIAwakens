//
//  Starships.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation



struct Starship {
    
    let name: String
    let make: String
    let cost: String
    let length: String
    let starshipClass: String
    let crew: String
    
    struct Key {
        
        static let name = "name"
        static let make = "model"
        static let cost = "cost_in_credits"
        static let length = "length"
        static let starshipClass = "starship_class"
        static let crew = "crew"
    }
    
    init?(json: [String: Any]) {
        
        guard let name = json[Key.name] as? String, let make = json[Key.make] as? String, let cost = json[Key.cost] as? String, let length = json[Key.length] as? String, let starshipClass = json[Key.starshipClass] as? String, let crew = json[Key.crew] as? String else {
            
            print("starship no work")
            return nil }
        
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
    }
}


extension Starship: Equatable {
    
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        
        return lhs.name == rhs.name && lhs.make == rhs.make && lhs.cost == rhs.cost && lhs.length == rhs.length && lhs.starshipClass == rhs.starshipClass && lhs.crew == rhs.crew
        
    }
}
