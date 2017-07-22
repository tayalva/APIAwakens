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
    
    
    let foods = ["Apples", "Bananas", "Beans", "Tomatoes", "Corn"]

    
 
     let networkCall = NetworkManager()
     var peopleNames: [String] = []
     var indexOfSelection: Int = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        populatePickerWheel()
     displayInfo()
        print(homePlanetURL)
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
                    
                    print(homePlanetURL)
                   
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
                    
                    self.nameLabel.text = starship.name
                    self.line1Label.text = starship.make
                    self.line2Label.text = starship.cost
                    self.line3Label.text = starship.length
                    self.line4Label.text = starship.starshipClass
                    self.line5Label.text = starship.crew
                    
                    print(fetchedInfo.count) } }
            
        case .vehicles:
            
             vehicleStarshipView.isHidden = false
             
            networkCall.fetchVehicle { fetchedInfo in
                
                
                let vehicle = fetchedInfo[self.indexOfSelection]
                
                OperationQueue.main.addOperation {
                    
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
        
        networkCall.fetchPerson { fetchedInfo in
            
            OperationQueue.main.addOperation {
                
            
            for person in fetchedInfo {
                
                self.peopleNames.append(person.name)
                
            }
                
            }
        }
        
        
    }

    // PickerView Helper Methods
    
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return peopleNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = peopleNames[row]
        indexOfSelection = row
        displayInfo()
        print(peopleNames)
    }
    
    
    // Network Request to fetch homeworld data
    

}
