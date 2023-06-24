//
//  ScanViewModelInput.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//


import Foundation
import CoreData

protocol AnalysisResultViewModelInput {
    func didAppear() async throws
    
    func saveToCoreData() async
}
