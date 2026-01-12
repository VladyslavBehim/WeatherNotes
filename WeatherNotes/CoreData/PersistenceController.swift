//
//  PersistenceController.swift
//  WeatherNotes
//
//  Created by Vladyslav Behim on 12.01.2026.
//


import Foundation
import CoreData
import UIKit

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init (){
        self.container = NSPersistentContainer(name: "WeatherNotesDB")
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                NSLog("Core Data error: \(error), \(error.userInfo)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(
                        title: "Data Error",
                        message: "Failed to load data. Please restart the app.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootVC = scene.windows.first?.rootViewController {
                        rootVC.present(alert, animated: true)
                    }
                }
            }else{
                print("Core Data store loaded successfully.")
            }
        }
    }
    
    func save(){
        let context = container.viewContext
        
        guard context.hasChanges else {return}
        do {
            try context.save()
        } catch{
            print("error savings context: \(error)")
        }
    }
    
 
}
