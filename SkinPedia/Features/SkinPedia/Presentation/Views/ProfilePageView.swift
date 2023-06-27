//
//  ProfilePageVie.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 27/06/23.
//

import SwiftUI

struct ProfilePageView: View {
    
    @StateObject var profileViewModel : ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    VStack{
                        Text("No allergen have been found.")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 14)
                        
                        Text("Start personalizing to identify any potential allergens in your skincare product")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 296.9)
                    .padding(.bottom, 21)
                    
                    
                    
                    Button {
                        profileViewModel.showProfiling = true
                    } label: {
                        Text("Start Personalization")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 82.5)
                            .padding(.vertical, 14)
                            .background(Color.customBrown)
                            .cornerRadius(12)
                    }
                    
                }
                .padding(.top, 35)
                .background(Color.lightestBrown)
                
                
                NavigationLink("", destination: profilingPage1(), isActive: $profileViewModel.showProfiling)
            }
            .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct profileViewProvider: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

