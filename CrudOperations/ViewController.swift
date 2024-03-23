//
//  ViewController.swift
//  CrudOperations
//
//  Created by Srijnasri Negi on 23/03/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        addData()
//        getData()
//        getData(byUsername: "1@dummy.com")
//        deleteAllData()
//        deleteData(byUsername: "1@dummy.com")
//        updateData(byUsername: "2@dummy.com", newValue: "12@dummy.com")
    }
    
    func addData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        for i in 1...5 {
            if let entity = entity {
                let user = NSManagedObject(entity: entity, insertInto: context)
                user.setValue("\(i)@dummy.com", forKey: "username")
                user.setValue("IAmDummy\(i)", forKey: "password")
            } else {
                print("No such entity found.")
            }
        }
        
        print("I am done creating!")
        appDelegate.saveContext()
    }
    
    func getData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]

        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "username") as! String)
                }
                print("Printed all data")
            } else {
                print("No records found.")
            }
        } catch {
            print("Not able to fetch data.")
        }
    }
    
    func getData(byUsername: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username==%@", byUsername)
//        fetchRequest.fetchLimit = 3
        
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "username") as! String)
                }
            } else {
                print("No records found.")
            }
        } catch {
            print("Not able to fetch data.")
        }
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    context.delete(data)
                }
                print("I am done deleting!")
            } else {
                print("No records found.")
            }
        } catch {
            print("Not able to fetch data.")
        }
        appDelegate.saveContext()
    }
    
    func deleteData(byUsername: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username==%@", byUsername)
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    context.delete(data)
                    print("deleted data: \(data.value(forKey: "username") as! String)")
                }
            } else {
                print("No records found.")
            }
        } catch {
            print("Not able to fetch data.")
        }
        appDelegate.saveContext()
    }
    
    func updateData(byUsername: String, newValue: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username==%@", byUsername)
        
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    data.setValue(newValue, forKey: "username")
                    print("Updated value: \(newValue), Old value: \(byUsername)")
                }
            } else {
                print("No records found.")
            }
        } catch {
            print("Not able to fetch data.")
        }
        appDelegate.saveContext()
    }
}

