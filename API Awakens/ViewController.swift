//
//  ViewController.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/5/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

 
// this simply changes the color of the nav bar at the top
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
     
        
       
     
        
    }

    
// this switches on an enum for each category so that I can successfully determine what code to execute depending on the type selected
    
    @IBAction func CategoryButtons(_ sender: UIButton) {
        
        
        switch sender.tag {
            
        case 0:
            selectedCategory = .people
          
            
        case 1:
            
            selectedCategory = .vehicles
        
        case 2:
            selectedCategory = .starships
            
        default: return
        }
        

        
    }
    
}



