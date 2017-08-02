//
//  DetailViewController.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/15/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import UIKit

var networkRequestDone = false

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    @IBOutlet weak var line3Label: UILabel!
    @IBOutlet weak var line4Label: UILabel!
    @IBOutlet weak var line5Label: UILabel!
    @IBOutlet weak var pickerWheel: UIPickerView!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var vehicleStarshipView: UIView!
    

    
 
     let networkCall = NetworkManager()
     var namesArray: [String] = []
     var starshipNames: [String] = []
     var vehicleNames: [String] = []
     var indexOfSelection: Int = 0
    var indexOfSmallest: Int = 0
     var personArray: [Person] = []
     var vehicleArray: [Vehicle] = []
     var starshipArray: [Starship] = []
     var sizeArray: [String] = []

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        namesArray.removeAll()
        networkRequest() { allDone in
            
            if allDone {
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                
                print("All done!")
                self.smallest()
                self.largest()
                
            }
            
            
            
            
        }
    
        
    
    }
    func smallest() {
        
        for size in self.personArray {
            
            self.sizeArray.append(size.height)
        }
        
        var newArray: [String] = []
        
        for replace in self.sizeArray {
            
            let newWord = replace.replacingOccurrences(of: "unknown", with: "9999999999")
            newArray.append(newWord)
        }
        print(newArray)
        
        let arrayInts = newArray.map {Int($0)!}
        
        
        let smallest = arrayInts.min()
        let index = arrayInts.index(of: smallest!)
        let smallestPerson = self.personArray[index!].name
        print(smallestPerson)
        
        print(self.personArray)
        OperationQueue.main.addOperation {
            
            self.smallestLabel.text = "\(smallestPerson)"
        }
        
    }
    
    
    func largest() {
        
        
        
        for size in personArray {
            
            sizeArray.append(size.height)
        }
        
        var newArray: [String] = []
        
        for replace in self.sizeArray {
            
            let newWord = replace.replacingOccurrences(of: "unknown", with: "0")
            newArray.append(newWord)
        }
        print(newArray)
        
        let arrayInts = newArray.map {Int($0)!}
        
        
        let largest = arrayInts.max()
        let index = arrayInts.index(of: largest!)
        let largestPerson = self.personArray[index!].name
        print(largestPerson)
        
        print(self.personArray)
        OperationQueue.main.addOperation {
            
            self.largestLabel.text = largestPerson
        }
    }

    
    
// Updates Labels with the appropriate information
    
    func networkRequest(completionHandler: @escaping (Bool) -> Void) {

 
        switch selectedCategory {
            
        case .people:
           
            vehicleStarshipView.isHidden = true
            
          
            networkCall.fetchPerson { fetchedInfo in
           
              self.personArray = fetchedInfo
                
               let names = fetchedInfo
               let person = fetchedInfo[self.indexOfSelection]
                
                print(names.count)
                
            
                homePlanetURL = person.home
                
                OperationQueue.main.addOperation {
                    
                    for person in names {
                        
                        self.namesArray.append(person.name)
                        
                    }
                    
                    self.namesArray.noDuplicates()
                    
                    self.pickerWheel.reloadAllComponents()
                    
                    self.displayInfo()
                 
            
   
                }
                self.networkCall.fetchPlanet {fetchedPlanet in
                    
                    
                    OperationQueue.main.addOperation {
                        self.line2Label.text = fetchedPlanet.name
                        
                        
                        
                    }
                    
                    
                    completionHandler(true)
                }
                
            
            }
            
            print(personArray.count)
        
  
    
        case .starships:
        
                 vehicleStarshipView.isHidden = false
            
            networkCall.fetchStarship { fetchedInfo in
                
                self.starshipArray = fetchedInfo
                
                let names = fetchedInfo
                let starship = fetchedInfo[self.indexOfSelection]
                
                OperationQueue.main.addOperation {
                  
                    for starship in names {
                        
                        self.namesArray.append(starship.name)
                    
                    }
                    self.namesArray.noDuplicates()
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
                
                self.vehicleArray = fetchedInfo
                
                let names = fetchedInfo
                let vehicle = fetchedInfo[self.indexOfSelection]
                
                OperationQueue.main.addOperation {
                 
                    for vehicle in names {
                        
                        self.namesArray.append(vehicle.name)
                    }
                    self.namesArray.noDuplicates()
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
    
    
    func fetchPlanet() {
        
        homePlanetURL = personArray[indexOfSelection].home
        
        networkCall.fetchPlanet {fetchedPlanet in
            
            
            OperationQueue.main.addOperation {
                self.line2Label.text = fetchedPlanet.name

            }
            
            
            
        }
        
        
    }
    func displayInfo() {
        
        switch selectedCategory {
            
        case .people:
            
            let person = personArray[indexOfSelection]
            namesArray.noDuplicates()
            
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()

            nameLabel.text = person.name
            line1Label.text = person.birthdate
            line3Label.text = person.height
            line4Label.text = person.eyeColor
            line5Label.text = person.hairColor
            
            
            fetchPlanet()
            
            
           
            
        case .starships:
            
            let starship = starshipArray[indexOfSelection]
            namesArray.noDuplicates()
            self.nameLabel.text = starship.name
            self.line1Label.text = starship.make
            self.line2Label.text = starship.cost
            self.line3Label.text = starship.length
            self.line4Label.text = starship.starshipClass
            self.line5Label.text = starship.crew
        
            
        case .vehicles:
            
            let vehicle = vehicleArray[indexOfSelection]
            namesArray.noDuplicates()
            self.nameLabel.text = vehicle.name
            self.line1Label.text = vehicle.make
            self.line2Label.text = vehicle.cost
            self.line3Label.text = vehicle.length
            self.line4Label.text = vehicle.vehicleClass
            self.line5Label.text = vehicle.crew
            
            
            
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
        
      
        
        indexOfSelection = row
        nameLabel.text = namesArray[row]
          displayInfo()
        print(indexOfSelection)
        
     
    }
    

    

}
