//
//  DetailViewController.swift
//  API Awakens
//
//  Created by Taylor Smith on 7/15/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var line1Label: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    @IBOutlet weak var line3Label: UILabel!
    @IBOutlet weak var line4Label: UILabel!
    @IBOutlet weak var line5Label: UILabel!
    
 
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        let networkCall = NetworkManager()
        networkCall.fetchPerson { fetchedInfo in
            
            
        let person = fetchedInfo.first
            
            OperationQueue.main.addOperation {
                
        
            self.nameLabel.text = person?.name
            self.line1Label.text = person?.birthdate
            self.line2Label.text = person?.home
            self.line3Label.text = person?.height
            self.line4Label.text = person?.eyeColor
            self.line5Label.text = person?.hairColor
            
           print(fetchedInfo.count)
            
        }
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func displayInfo() {
        
        
   
    }

}
