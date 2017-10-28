//
//  PantryManager.swift
//  Fridgemate
//
//  Created by Kadeem Palacios on 1/13/17.
//  Copyright © 2017 Kadeem. All rights reserved.
//

import UIKit
import CoreData

class KeyManager {

    // MARK: - Vars
    static let sharedInstance = KeyManager()
    var keysArray = [NSManagedObject]()
    var context: NSManagedObjectContext?

    var count:Int {
        get {
            return keysArray.count
        }
    }

    // Init
    init() {
        loadData()
    }

    // MARK: - Functions

    // Load Data
    func loadData() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        context = appDelegate.persistentContainer.viewContext

        let request: NSFetchRequest<Key> = Key.fetchRequest()

        do {
            let results = try context?.fetch(request)
            keysArray = results!
            print(keysArray)
            return keysArray
        }
        catch {
            fatalError("Error in retrieving pantry list")
        }
    }

    func keyAt(index:Int) -> String {
        let key = keysArray[index]
        return key.value(forKey: "label") as! String
    }
    func keyContentAt(index:Int) -> String {
        let key = keysArray[index]
        return key.value(forKey: "content") as! String
    }

    // Add a new key
    func addKey(label: String, content:String?) {
        print(#line)
        print(#function)
        print(label)
        let entity = NSEntityDescription.entity(forEntityName: "Key", in: (context)!)
        let key = NSManagedObject(entity: entity!, insertInto: context)
        key.setValue(label, forKey: "label")
        if content != nil {
            key.setValue(content, forKey: "content")
        }
        else {
            key.setValue(label, forKey: "content")
        }
        print("----------")
        print(key)

        keysArray.append(key)
        // or loadData after save...

        do {
            try context?.save()
            print("Pantry Count Saved. Current Count : \(count)")
        } catch let error as NSError {
            print("Error: \(error) \(error.userInfo)" )
            fatalError("PantryManager * Error in storing to data")
        }
    }

    /// Remove key at index

    func remove(index:Int) {

        print("remove index:\(index)")
        print("remove count:\(keysArray.count)")

        let item = keysArray.remove(at: index)

        // TODO: Remove from Core Data!
        context?.delete(item)
        save()
    }

    /// Clear all keys
    func clear() {
        keysArray = []
        // TODO: Remove all items from Core Data
        save()
    }

    /// Save keys to core data! Updates core data store.
    func save() {
        do {
            try context?.save()
        } catch {
            print("Error saving context")
        }
    }

    func toString() -> String {
        keysArray = loadData()
        var str = ""
        for key in keysArray {
            str += key.value(forKey: "item") as! String
            str += ", "
        }
        return str
    }

}

