//
//  Data Models.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/14/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation


var selectedCategory: CategorySelected = .people
var homePlanetURL: String = ""


enum CategorySelected {
    
    case people
    case starships
    case vehicles
    
}

extension Array where Element: Equatable {
    
    mutating func noDuplicates() {
        
        var uniqueElements:[Element] = []
        
        for element in self {
            
            if !uniqueElements.contains ( element ) {
                
                uniqueElements.append(element)
            }
        }
        
        self = uniqueElements
    }
    
}


extension String {
    func removeFormatting() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as? Double
    }
}
