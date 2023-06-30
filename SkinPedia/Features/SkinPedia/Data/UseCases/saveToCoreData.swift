//
//  saveToCoreData.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 28/06/23.
//

import Foundation

struct saveToCoreDataUseCase {
    
    let skinPediaRepository : SkinPediaRepository = SkinPediaRepository()
    
    func save(name : String, fetchResult:String) async {
        await skinPediaRepository.saveToCoreData(name: name, fetchResult: fetchResult)
    }
}
