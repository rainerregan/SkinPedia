//
//  saveToCoreData.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 28/06/23.
//

import Foundation
import CoreData
struct saveToCoreDataUseCase {
    
    let skinPediaRepository : SkinPediaRepository = SkinPediaRepository()
    
    func save(name : String, moc : NSManagedObjectContext) async {
        await skinPediaRepository.saveToCoreData(name: name, moc: moc)
    }
}
