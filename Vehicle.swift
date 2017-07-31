//
//  Vehicles.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


struct Vehicle {
    
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crew: String
    
    struct Key {
        
        static let name = "name"
        static let make = "model"
        static let cost = "cost_in_credits"
        static let length = "length"
        static let vehicleClass = "vehicle_class"
        static let crew = "crew"
    }
    
    init?(json: [String: Any]) {
        
        guard let name = json[Key.name] as? String, let make = json[Key.make] as? String, let cost = json[Key.cost] as? String, let length = json[Key.length] as? String, let vehicleClass = json[Key.vehicleClass] as? String, let crew = json[Key.crew] as? String else {
            
            print("vehicle no work")
            return nil }
        
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
}


extension Vehicle: Equatable {
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        
        return lhs.name == rhs.name && lhs.make == rhs.make && lhs.cost == rhs.cost && lhs.length == rhs.length && lhs.vehicleClass == rhs.vehicleClass && lhs.crew == rhs.crew
        
    }
}
