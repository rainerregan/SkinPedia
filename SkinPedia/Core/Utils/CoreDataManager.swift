//
//  CoreDataManager.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 16/06/23.
//

import Foundation
import CoreData

class coreDataManager : ObservableObject  {
    let container : NSPersistentContainer = NSPersistentContainer(name: "SkinPediaModel")
    
    init() {
        container.loadPersistentStores{
            description, err in
                if let e = err {
                    fatalError("Core Data failed to load, Message : \(e.localizedDescription)")
            }
        }
    }
}
