//
//  MainProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewViewModel : MainViewViewModel = MainViewViewModel()
    
    var body: some View {
        TabView(selection : $mainViewViewModel.seletedView){
            
            CameraView()
                .tabItem{
                    Label("Scan", systemImage: "viewfinder")
                }
                .tag(0)
            
            ProfilePageView()
                .environmentObject(mainViewViewModel)
                .tabItem{
                    Label("Profile", systemImage: "person.fill")
                    
                }
                .tag(1)
        }
    }
    
    var profile : some View {
        VStack{
            
        }
    }
    
}


