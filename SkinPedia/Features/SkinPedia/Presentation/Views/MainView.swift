//
//  MainProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct MainProfileView: View {
    
    @State var seletedView : Int = 0;
    
    var body: some View {
        TabView(selection : $seletedView){
            profile
                .tabItem{
                    Label("Scan", systemImage: "viewfinder")
                    
                }
                .tag(0)
            
            
        }
    }
    
    var profile : some View {
        VStack
        {
            
        }
    }
    
}

struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView()
    }
}
