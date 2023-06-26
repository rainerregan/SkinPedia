//
//  ProfilePage2.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 26/06/23.
//

import SwiftUI

struct ProfilePage2: View {
    
    @State var SkinCareName : String = ""
    @State var ableToContinue : Bool = false
    var body: some View {
        ProfileView(alignment: .leading){
            Text("What was that product?")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Help us to identify what were 3 products that caused the side effects.")
                .padding(.bottom, 15)
            
            VStack(spacing: 0){
                Text("Skincare Product")
                    .foregroundColor(.customDarkGray)
                    .padding(.bottom, 4)
                TextField("Input Skincare Name", text: $SkinCareName)
            }
            .background(Color.customLightGray)
            .cornerRadius(12)
            
            Button{
                
            } label: {
                Text("Continue")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 14, leading: 157, bottom: 14, trailing: 157))
                    .background(Color.customBrown)
                    .cornerRadius(12)
                    .foregroundColor((ableToContinue) ? .white : .customMediumGray.opacity(0.8))
            }
        }
    }
}

struct ProfilePage2_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage2()
    }
}
