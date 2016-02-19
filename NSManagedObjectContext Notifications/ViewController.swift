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
    
   // createData()
        
        guard let context = context, existingBikes = fetchBikes(context) else {return}
        updateUI(existingBikes)
    
  //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedGeneralNotification:", name: nil, object: context)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedObjectChangeNotification:", name: NSManagedObjectContextObjectsDidChangeNotification, object: context)
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeValueTapped(sender: UIButton) {
        guard let context = context, existingBikes = fetchBikes(context) else {return}
        changeValues(existingBikes[0])
        updateUI(existingBikes)
    }
    
    @IBAction func saveTapped(sender: UIButton) {
        
        guard let context = context else {return}
        saveToCoreData(context)
        
        
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
    
    func fetchBikes(context: NSManagedObjectContext) -> [Bike]? {
        let request = NSFetchRequest(entityName: "Bike")
        let descriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [descriptor]
        
        do {
            guard let bikes = try context.executeFetchRequest(request) as? [Bike] else {return nil}
            print(bikes.map{"Name: \($0.name!), Model: \($0.model!)"}.joinWithSeparator("\n"))
            return bikes
        } catch {
            print("We couldn't fetch.")
        }
        return nil
    }
    
    func updateUI(bikes: [Bike]) {
        messagesLabel.text = bikes.map(bikeToDescription).joinWithSeparator("\n\n")
    }
    
    func bikeToDescription(bike: Bike) -> String {
        guard let name = bike.name, model = bike.model, wheelSize = bike.wheelSize else {return ""}
        return "Name: \(name), Model: \(model), wheelSize: \(wheelSize)"
    }
    
    func returnRandomString(originalName: String) -> String {
        var numbers: String = String()
        for _ in 0...2 {
            numbers += String(arc4random_uniform(11))
        }
        return originalName + numbers
    }
    
    func changeValues(bike: Bike) {
        guard let firstName = bike.name else {return}
        bike.name = returnRandomString(firstName)
    }
    
    func saveToCoreData(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error: Could not save to Core Data.")
        }
    }
    
    func receivedGeneralNotification(notification: NSNotification) {
        notificationsLabel.text = "Received a notification of some kind for NSManagedObjectContext"
    }
    
    func receivedObjectChangeNotification(notification: NSNotification) {
        guard let set = (notification.userInfo![NSUpdatedObjectsKey] as? NSSet) else {return}
        let updatedItemsArray = set.allObjects
        guard let firstItem = updatedItemsArray[0] as? Bike else {return}
        guard let bikeName = firstItem.name else {return}
        notificationsLabel.text = "Received a notification for a Changing Object with name: \(bikeName)."
    }
    
    
    
}

