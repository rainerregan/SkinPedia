//
//  ScanViewModelInput.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//


import Foundation
import CoreData

protocol AnalysisResultViewModelInput {
    func didAppear(moc : NSManagedObjectContext) async throws
    func saveToCoreData(name : String, fetchResult: String, moc : NSManagedObjectContext) async;
    
    
}
