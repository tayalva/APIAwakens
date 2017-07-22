//
//  Data Models.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/14/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


var selectedCategory: CategorySelected = .starships
var homePlanetURL: String = ""


enum CategorySelected {
    
    case people
    case starships
    case vehicles
    
}

