//
//  Planet.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/21/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation



struct Planet {
    
    let name: String?
    
    init?(json: [String : AnyObject]) {
        
        guard let name = json["name"] as? String else {
            
            print("no planet")
            return nil
            
        }
        
        self.name = name
    }
    
}
