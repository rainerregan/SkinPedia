//
//  ProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct ProfileView<CustomContent : View>: View {
    
    var customContent : () -> CustomContent
    
    init(@ViewBuilder customContent: @escaping () -> CustomContent) {
        self.customContent = customContent
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
                customContent()
                
            }.navigationBarTitle("Profiling")
                .accentColor(.customBrown)
        }
    }
}



