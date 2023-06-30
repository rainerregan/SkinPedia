//
//  SkinPediaApp.swift
//  SkinPedia
//
//  Created by Rainer Regan on 16/06/23.
//

import SwiftUI

@main
struct SkinPediaApp: App {
    
    @StateObject var manager : coreDataManager = coreDataManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, manager.container.viewContext)
                .preferredColorScheme(.light)
                .onAppear{
                    print("Testing masuk")
                }
        }
    }
}
