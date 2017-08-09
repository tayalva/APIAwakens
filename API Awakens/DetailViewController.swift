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
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var associatedVehicleView: UIView!
    
    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var starshipLabel: UILabel!
    
    @IBOutlet weak var vehicleStarshipView: UIView!
    

    
 
     let networkCall = NetworkManager()
     var namesArray: [String] = []
     var starshipNames: [String] = []
     var vehicleNames: [String] = []
     var indexOfSelection: Int = 0
     var personArray: [Person] = []
     var vehicleArray: [Vehicle] = []
     var starshipArray: [Starship] = []
     var sizeArray: [String] = []
     var credits: Int = 0
     var metric: Double = 0.0
    var english: Double = 0.0
    var USD: Double = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        removeArrayElements()
        networkRequest() { allDone in
            
            if allDone {
              
                print("all done!")
                self.smallest()
                self.largest()
      
                
  
            }
        }

    }

    @IBAction func conversionButtons(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 0:  //USD
            
        
            let alert = UIAlertController(title: "Convert to USD", message: "Please enter a conversion rate", preferredStyle: .alert)
            let action = UIAlertAction(title: "Convert", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
                if textField.text != "" && textField.text != "0" {
                    self.USD = self.credits.toUSD(conversionRate: Double(textField.text!)!)
                 self.line2Label.text = "$\(self.USD)"
                }
        }
            
            alert.addTextField { (textField) in
                textField.keyboardType = UIKeyboardType.decimalPad
                textField.placeholder = "Enter rate"
            }
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
 
            
        case 1: //Credits
            
            line2Label.text = "\(credits)"
            
            
        case 2:
            if selectedCategory == .people {
                
                line3Label.text = "\(metric) cm"
                
            } else {
            line3Label.text = "\(metric) meters"
            }
            
        case 3:
            
            if selectedCategory == .people {
                line3Label.text = "\(metric.toFeetFromCm()) feet"
                
            } else {
            line3Label.text = "\(metric.toFeetFromMeter()) feet"
            }
            
        default: break
            
            
        }
        
        
    }

    
    
// Updates Labels with the appropriate information
    
    func networkRequest(completionHandler: @escaping (Bool) -> Void) {

 
        switch selectedCategory {
            
        case .people:
            associatedVehicleView.isHidden = false
            vehicleStarshipView.isHidden = true
            usdButton.isHidden = true
            creditsButton.isHidden = true
            networkCall.fetchPerson { fetchedInfo in
              self.personArray = fetchedInfo
               let names = fetchedInfo
               let person = fetchedInfo[self.indexOfSelection]
                homePlanetURL = person.home
                OperationQueue.main.addOperation {
                    for person in names {
                        self.namesArray.append(person.name)
                    }
                    self.namesArray.noDuplicates()
                    self.pickerWheel.reloadAllComponents()
                    self.displayInfo()
                    self.loadingIndicator.isHidden = true
                }
                self.networkCall.fetchPlanet {fetchedPlanet in
                    OperationQueue.main.addOperation {
                        self.line2Label.text = fetchedPlanet.name
                    }
                    
                    
                  
                   
                }
                
  
                
                completionHandler(true)
            }

        case .starships:
            associatedVehicleView.isHidden = true
            usdButton.isHidden = false
            creditsButton.isHidden = false
                vehicleStarshipView.isHidden = false
            networkCall.fetchStarship { fetchedInfo in
                self.starshipArray = fetchedInfo
                let names = fetchedInfo
                OperationQueue.main.addOperation {
                    for starship in names {
                        self.namesArray.append(starship.name)
                    }
                    self.namesArray.noDuplicates()
                    self.pickerWheel.reloadAllComponents()
                self.displayInfo()
                    self.loadingIndicator.isHidden = true
                     }
            completionHandler(true)
            }
            
        
            
        case .vehicles:
                associatedVehicleView.isHidden = true
            usdButton.isHidden = false
            creditsButton.isHidden = false
             vehicleStarshipView.isHidden = false
             networkCall.fetchVehicle { fetchedInfo in
                self.vehicleArray = fetchedInfo
                let names = fetchedInfo
                OperationQueue.main.addOperation {
                    for vehicle in names {
                        self.namesArray.append(vehicle.name)
                    }
                    self.namesArray.noDuplicates()
                    self.pickerWheel.reloadAllComponents()
                    self.displayInfo()
                    self.loadingIndicator.isHidden = true
                }
            completionHandler(true)
            }
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
    
    
    
    func fetchAssociatedVehicles() {
        
        self.networkCall.itemCount = self.networkCall.vehicleUrlArray.count - 1
        self.networkCall.fetchPersonVehicles { fetchedVehicle in
        
        var vehicleArray: [String] = []
        
        
        for x in fetchedVehicle {
            
            vehicleArray.append(x.name)
            
        }
        
        OperationQueue.main.addOperation {
            
            self.vehicleLabel.text = vehicleArray.joined(separator: ", ")
            
            print(fetchedVehicle)
            
            
        }
        
    }
    
    }
    
    func fetchAssociatedStarships() {
        
        self.networkCall.itemCountStarships = self.networkCall.starshipUrlArray.count - 1
        self.networkCall.fetchPersonStarships { fetchedStarship in
            
            var starshipArray: [String] = []
            
            
            for x in fetchedStarship {
                
                starshipArray.append(x.name)
                
            }
            
            OperationQueue.main.addOperation {
                
                self.starshipLabel.text = starshipArray.joined(separator: ", ")
                
                print(fetchedStarship)
                
                
            }
            
        }
        
    }
    func displayInfo() {
        
        switch selectedCategory {
            
        case .people:
            networkCall.associatedVehiclesArray.removeAll()
            networkCall.associatedStarshipsArray.removeAll()
            let person = personArray[indexOfSelection]
            self.networkCall.vehicleUrlArray = person.vehicles
            self.networkCall.itemCount = self.networkCall.vehicleUrlArray.count
            
            self.networkCall.starshipUrlArray = person.starships
            self.networkCall.itemCountStarships = self.networkCall.starshipUrlArray.count
            
            namesArray.noDuplicates()
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            nameLabel.text = person.name
            line1Label.text = person.birthdate
            line4Label.text = person.eyeColor
            line5Label.text = person.hairColor
            fetchPlanet()
            
            if person.height == "unknown" {
                
                line3Label.text = "unknown"
            } else {
                
                self.metric = Double(person.height)!
                   line3Label.text = "\(self.metric) cm"
            }
            
            if person.vehicles != [] {
            fetchAssociatedVehicles()
            } else {
                vehicleLabel.text = "No associated vehicles!"
            }
            
            if person.starships != [] {
                
                fetchAssociatedStarships()
            } else {
                
                starshipLabel.text = "no associated Starships!"
            }
 
        case .starships:
            let starship = starshipArray[indexOfSelection]
            namesArray.noDuplicates()
            
            if starship.cost == "unknown" {
                
                self.usdButton.isHidden = true
                self.creditsButton.isHidden = true
                self.line2Label.text = starship.cost
                
            } else {
                
                self.usdButton.isHidden = false
                self.creditsButton.isHidden = false
                self.credits = Int(starship.cost)!
                self.line2Label.text = "\(self.credits) credits"
            }
            
            self.nameLabel.text = starship.name
            self.line1Label.text = starship.make
    
            self.metric = Double(starship.length)!
            self.line3Label.text = "\(self.metric) meters"
            self.line4Label.text = starship.starshipClass
            self.line5Label.text = starship.crew
            
            self.metric = Double(starship.length)!
        
        case .vehicles:
            
        
            let vehicle = vehicleArray[indexOfSelection]
            namesArray.noDuplicates()
            
            if vehicle.cost == "unknown" {
                
                self.usdButton.isHidden = true
                self.creditsButton.isHidden = true
                self.line2Label.text = vehicle.cost
                
            } else {
                
                self.usdButton.isHidden = false
                self.creditsButton.isHidden = false
                self.credits = Int(vehicle.cost)!
                self.line2Label.text = "\(credits) credits"
            }
            self.nameLabel.text = vehicle.name
            self.line1Label.text = vehicle.make
            self.metric = Double(vehicle.length)!
            self.line3Label.text = "\(metric) meters"
            self.line4Label.text = vehicle.vehicleClass
            self.line5Label.text = vehicle.crew
            
        }
        self.loadingIndicator.isHidden = true
        self.loadingIndicator.stopAnimating()

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

    }
    
    func removeArrayElements() {
        
        namesArray.removeAll()
        starshipArray.removeAll()
        personArray.removeAll()
        vehicleArray.removeAll()
        sizeArray.removeAll()
    }
    
    func smallest() {
        
        switch selectedCategory {
            
        case .people:
            
            for size in self.personArray {
                self.sizeArray.append(size.height)
            }
            
            var newArray: [String] = []
            for replace in self.sizeArray {
                let newWord = replace.replacingOccurrences(of: "unknown", with: "9999999999")
                newArray.append(newWord)
                
            }
            let arrayInts = newArray.map {Int($0)!}
            let smallest = arrayInts.min()
            let index = arrayInts.index(of: smallest!)
            let smallestObject = self.personArray[index!].name
            
            OperationQueue.main.addOperation {
                self.smallestLabel.text = smallestObject
            }
            
        case .starships:
            
            for size in self.starshipArray {
                self.sizeArray.append(size.length)
            }
            
            var newArray: [String] = []
            for replace in self.sizeArray {
                let newWord = replace.replacingOccurrences(of: "unknown", with: "9999999999")
                newArray.append(newWord)
                
            }
            
            let formattedArray = newArray.map {$0.removeFormatting()!}
            let smallest = formattedArray.min()
            let index = formattedArray.index(of: smallest!)
            let smallestObject = self.starshipArray[index!].name
            
            OperationQueue.main.addOperation {
                self.smallestLabel.text = smallestObject
            }
            
        case .vehicles:
            
            for size in self.vehicleArray {
                self.sizeArray.append(size.length)
            }
            
            var newArray: [String] = []
            for replace in self.sizeArray {
                let newWord = replace.replacingOccurrences(of: "unknown", with: "9999999999")
                newArray.append(newWord)
            }
            let arrayDouble = newArray.map {Double($0)!}
            let smallest = arrayDouble.min()
            let index = arrayDouble.index(of: smallest!)
            let smallestObject = self.vehicleArray[index!].name
            
            OperationQueue.main.addOperation {
                self.smallestLabel.text = smallestObject
            }
            
            
        }
    }
    
    func largest() {
        
        switch selectedCategory {
            
        case .people:
            for size in personArray {
                sizeArray.append(size.height)
            }
            var newArray: [String] = []
            for replace in self.sizeArray {
                let newWord = replace.replacingOccurrences(of: "unknown", with: "0")
                newArray.append(newWord)
            }
            let arrayInts = newArray.map {Int($0)!}
            let largest = arrayInts.max()
            let index = arrayInts.index(of: largest!)
            let largestPerson = self.personArray[index!].name
            OperationQueue.main.addOperation {
                
                self.largestLabel.text = largestPerson
            }
            
        case .starships:
            for size in starshipArray {
                sizeArray.append(size.length)
            }
            var newArray: [String] = []
            for replace in self.sizeArray {
                
                let newWord = replace.replacingOccurrences(of: "unknown", with: "0")
                newArray.append(newWord)
            }
            
            let formattedArray = newArray.map {$0.removeFormatting()!}
            let largest = formattedArray.max()
            let index = formattedArray.index(of: largest!)
            let largestObject = self.starshipArray[index!].name
            
            OperationQueue.main.addOperation {
                
                self.largestLabel.text = largestObject
            }
        case .vehicles:
            for size in vehicleArray {
                sizeArray.append(size.length)
            }
            var newArray: [String] = []
            for replace in self.sizeArray {
                let newWord = replace.replacingOccurrences(of: "unknown", with: "0")
                newArray.append(newWord)
            }
            let arrayInts = newArray.map {Double($0)!}
            let largest = arrayInts.max()
            let index = arrayInts.index(of: largest!)
            let largestObject = self.vehicleArray[index!].name
            OperationQueue.main.addOperation {
                self.largestLabel.text = largestObject
            }
        }
    }

    

}
