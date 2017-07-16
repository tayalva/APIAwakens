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
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        print(selectedCategory)
        
       
     
        
    }

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
        
        networkCall()

        
    }
    
    
    func networkCall() {
        
        let networkCall = NetworkManager()
        
        networkCall.fetchData { (fetchedInfo) in
            
            print(fetchedInfo)
            
        }
    }




}

