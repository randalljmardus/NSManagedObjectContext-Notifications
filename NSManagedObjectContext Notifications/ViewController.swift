//
//  ViewController.swift
//  NSManagedObjectContext Notifications
//
//  Created by Randall Mardus on 2/19/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var notificationsLabel: UILabel!
    
    @IBOutlet weak var messagesLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    createData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeValueTapped(sender: UIButton) {
    }
    
    @IBAction func saveTapped(sender: UIButton) {
    }
    
    func createData() {
        
        let newBikes = [(name: "Snake", brand: "Giant", model: "Reign 2 LTD", wheelSize: 27.5), (name: "HardTail", brand: "Connor", model: "8500 Deore", wheelSize: 29.0)]
        for bike in newBikes {
            guard let newBike = NSEntityDescription.insertNewObjectForEntityForName("Bike", inManagedObjectContext: context!) as? Bike else {continue}
            newBike.name = bike.name
            newBike.brand = bike.brand
            newBike.model = bike.model
            newBike.wheelSize = bike.wheelSize
        }
        
        do {
            try context!.save()
        } catch {
            print("Error saving.")
        }
    }
}

