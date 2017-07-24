//
//  DetailViewController.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/15/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    @IBOutlet weak var line3Label: UILabel!
    @IBOutlet weak var line4Label: UILabel!
    @IBOutlet weak var line5Label: UILabel!
    @IBOutlet weak var pickerWheel: UIPickerView!
    
    @IBOutlet weak var vehicleStarshipView: UIView!
    

    
 
     let networkCall = NetworkManager()
     var namesArray: [String] = []
     var starshipNames: [String] = []
     var vehicleNames: [String] = []
     var indexOfSelection: Int = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        populatePickerWheel()
        displayInfo()
        
    
    }
    

    
    
// Updates Labels with the appropriate information 
    
func displayInfo() {

    
        switch selectedCategory {
            
        case .people:
           
            
            vehicleStarshipView.isHidden = true
            
            networkCall.fetchPerson { fetchedInfo in
                
                
                let person = fetchedInfo[self.indexOfSelection]
                
            
                homePlanetURL = person.home
                    
                    
                OperationQueue.main.addOperation {
            
                    self.pickerWheel.reloadAllComponents()
                    self.nameLabel.text = person.name
                    self.line1Label.text = person.birthdate
                    self.line3Label.text = person.height
                    self.line4Label.text = person.eyeColor
                    self.line5Label.text = person.hairColor
                    
                   
                    }
            
            
            
                self.networkCall.fetchPlanet {fetchedPlanet in
                    
                    
                    OperationQueue.main.addOperation {
                        self.line2Label.text = fetchedPlanet.name
                    }
                    
                }
                
            
            
            }
           
     
            
        case .starships:
            
                 vehicleStarshipView.isHidden = false
            
            networkCall.fetchStarship { fetchedInfo in
                
                let starship = fetchedInfo[self.indexOfSelection]
                
                OperationQueue.main.addOperation {
                  
                    self.pickerWheel.reloadAllComponents()
                    self.nameLabel.text = starship.name
                    self.line1Label.text = starship.make
                    self.line2Label.text = starship.cost
                    self.line3Label.text = starship.length
                    self.line4Label.text = starship.starshipClass
                    self.line5Label.text = starship.crew
                    
                     } }
            
        case .vehicles:
            
             vehicleStarshipView.isHidden = false
             
            networkCall.fetchVehicle { fetchedInfo in
                
                let vehicle = fetchedInfo[self.indexOfSelection]
                
                OperationQueue.main.addOperation {
                 
                    self.pickerWheel.reloadAllComponents()
                    self.nameLabel.text = vehicle.name
                    self.line1Label.text = vehicle.make
                    self.line2Label.text = vehicle.cost
                    self.line3Label.text = vehicle.length
                    self.line4Label.text = vehicle.vehicleClass
                    self.line5Label.text = vehicle.crew
                    
                   } }
        
   
    }

}
 
    // Function to populate the picker wheel with names from the JSON data
    
    func populatePickerWheel() {
        
        
        switch selectedCategory {
            
        case .people:
            
            networkCall.fetchPerson { fetchedInfo in
                
                let names = fetchedInfo
                
                OperationQueue.main.addOperation {
                    
                    
                    for person in names {
                        
                        self.namesArray.append(person.name) }
                    
                    self.pickerWheel.reloadAllComponents()
                }
                
                
            
                
            }
            
        case .vehicles:
            
            
            networkCall.fetchVehicle { fetchedInfo in
                
                let names = fetchedInfo
                
                
                OperationQueue.main.addOperation {
                    
                    
                    for vehicle in names {
                        
                        self.namesArray.append(vehicle.name) }
                    self.pickerWheel.reloadAllComponents()
                }
              
                
            }
            
        case .starships:
            
            networkCall.fetchStarship { fetchedInfo in
                
                let names = fetchedInfo
                
                OperationQueue.main.addOperation {
                    
                    
                    for starship in names {
                        
                        self.namesArray.append(starship.name) }
                    self.pickerWheel.reloadAllComponents()
                }
               
                
            }
            
        }
        
        
        
    
}
    


    // PickerView Helper Methods
    
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return namesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return namesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
        displayInfo()
        nameLabel.text = namesArray[row]
        indexOfSelection = row
    }
    
    
    // Network Request to fetch homeworld data
    

}
