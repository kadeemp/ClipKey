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
    let constants = Constants()
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
        let coreDataStack = CoreDataStack()

        context = coreDataStack.persistentContainer.viewContext

        let request: NSFetchRequest<Key> = Key.fetchRequest()

        do {
            let results = try context?.fetch(request)
            keysArray = results!
            var titles:[String] = []
            var keys:[String] = []

            for i in 0..<keysArray.count{
                let key = keysArray[i]
                let label = key.value(forKey: constants.label) as! String
                titles.append(label)
                let content =  key.value(forKey: constants.content) as! String
                keys.append(content)
            }

            return keysArray
        }
        catch {
            fatalError("Error in retrieving pantry list")
        }
    }

    func loadDefaults(){

        getKeys()
        getTitles()

    }
    func setKeys(keys:[String]) {
        constants.userDefaults?.set(keys, forKey: "keys")
    }
    func setTitles(titles:[String]) {
        constants.userDefaults?.set(titles, forKey: "titles")
    }
    func getKeys() -> [String] {
        var keys = (constants.userDefaults?.stringArray(forKey: "keys"))!
        return keys
    }
    func getTitles() -> [String] {
        var titles = constants.userDefaults?.array(forKey: "titles") as! [String]
        return titles
    }

    func keyAt(index:Int) -> NSManagedObject {
        let key = keysArray[index]
        return key
    }
    func keyLabelAt(index:Int) -> String {
        let key = keysArray[index]
        return key.value(forKey: "label") as! String
    }
    func keyContentAt(index:Int) -> String {
        let key = keysArray[index]
        return key.value(forKey: "content") as! String
    }

    func addKey(label: String, content:String?) {

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
            print("Key Count Saved. Current Count : \(count)")
        } catch let error as NSError {
            print("Error: \(error) \(error.userInfo)" )
            fatalError("KeyManager * Error in storing to data")
        }
    }

    /// Remove key at index

    func remove(index:Int) {

        let item = keysArray.remove(at: index)


        context?.delete(item)
        save()
    }

    /// Clear all keys
    func clear() {
        keysArray = []
        
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

