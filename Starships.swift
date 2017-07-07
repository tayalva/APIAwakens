//
//  Starships.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation



class Starships {
    
    let make: String
    let cost: Int
    let length: Double
    let starShipClass: String
    let crew: Int
    
    init(make: String, cost: Int, length: Double, starShipClass: String, crew: Int) {
        
        self.make = make
        self.cost = cost
        self.length = length
        self.starShipClass = starShipClass
        self.crew = crew 
    }
}
