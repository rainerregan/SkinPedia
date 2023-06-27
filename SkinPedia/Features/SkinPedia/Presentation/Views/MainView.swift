//
//  MainProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct MainView: View {
    
    @State var seletedView : Int = 0;
    
    var body: some View {
        TabView(selection : $seletedView){
            
            CameraView()
                .tabItem{
                    Label("Scan", systemImage: "viewfinder")
                }
                .tag(0)
            
            ProfilePageView()
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


