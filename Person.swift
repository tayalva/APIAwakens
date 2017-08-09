//
//  People.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


struct Person {
    
    let name: String
    let birthdate: String
    let home: String
    let height: String
    let eyeColor: String
    let hairColor: String
    let vehicles: [String]
    let starships: [String]
  
    
    struct Key {
        static let name = "name"
        static let birthdate = "birth_year"
        static let home = "homeworld"
        static let height = "height"
        static let eyeColor = "eye_color"
        static let hairColor = "hair_color"
        static let vehicles = "vehicles"
        static let starships = "starships"
    }
    
     init?(json: [String: Any]) {
        
       
        
        guard let name = json[Key.name] as? String, let birthdate = json[Key.birthdate] as? String, let home = json[Key.home] as? String, let height = json[Key.height] as? String, let eyeColor = json[Key.eyeColor] as? String, let hairColor = json[Key.hairColor] as? String, let vehicles = json[Key.vehicles] as? [String], let starships = json[Key.starships] as? [String] else {
            
            print("not working!")
            return nil }
        
        self.name = name
        self.birthdate = birthdate
        self.home = home
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.vehicles = vehicles
        self.starships = starships
        
    }
}

extension Person: Equatable {
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        
        return lhs.name == rhs.name && lhs.birthdate == rhs.birthdate && lhs.home == rhs.home && lhs.height == rhs.height && lhs.eyeColor == rhs.eyeColor && lhs.hairColor == rhs.hairColor && lhs.vehicles == rhs.vehicles && lhs.starships == lhs.starships
        
    }
}
