//
//  SkinPediaApp.swift
//  SkinPedia
//
//  Created by Rainer Regan on 16/06/23.
//

import SwiftUI

@main
struct SkinPediaApp: App {
    
    @StateObject var model = coreDataManager(modelName: "SkinPediaModel")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, model.container.viewContext)
        }
    }
}
