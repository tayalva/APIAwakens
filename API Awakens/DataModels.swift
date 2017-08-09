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

extension Int {
    
    func toUSD(conversionRate rate: Double) -> Double {
        let x = Double(self)/rate
        let divisor = pow(10.0, Double(2))
        return round(x * divisor) / divisor
    }
}

extension Double {
    
    mutating func toFeetFromCm() -> Double {
        let x = Double(self) / 30.48
        let divisor = pow(10.0, Double(2))
        
        return Darwin.round(x * divisor) / divisor
    }
    
    mutating func toFeetFromMeter() -> Double {
        let x = Double(self) * 3.28084
        let divisor = pow(10.0, Double(2))
        
        return Darwin.round(x * divisor) / divisor 
    }
}
