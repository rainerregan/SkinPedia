//
//  ProfileView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Did your skincare ever give you some side effects?")
                    .font(.title3)
                    
                Text("Skincare products may cause side effects, such as:")
                
                
            }.navigationBarTitle("Profiling")
                .accentColor(.brown)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
