//
//  Vehicles.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


class Vehicles {
    
    let make: String
    let cost: Int
    let length: Double
    let vehicleClass: String
    let crew: Int
    
    init(make: String, cost: Int, length: Double, vehicleClass: String, crew: Int) {
        
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
}
