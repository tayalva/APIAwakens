//
//  People.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import Foundation



struct Person {
    
  
    let birthdate: String
    let home: String
    let height: String
    let eyeColor: String
    let hairColor: String
  
    
    struct Key {
        
        static let birthdate = "birth_year"
        static let home = "homeworld"
        static let height = "height"
        static let eyeColor = "eye_color"
        static let hairColor = "hair_color"
    }
    
     init?(json: [String: Any]) {
        
       
        
        guard let birthdate = json[Key.birthdate] as? String, let home = json[Key.home] as? String, let height = json[Key.height] as? String, let eyeColor = json[Key.eyeColor] as? String, let hairColor = json[Key.hairColor] as? String else {
            
            print("not working!")
            return nil }
        
        
        self.birthdate = birthdate
        self.home = home
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
    }
}
