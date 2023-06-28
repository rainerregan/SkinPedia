//
//  ProfilePageVie.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 27/06/23.
//

import SwiftUI

struct ProfilePageView: View {
    
    @StateObject var profileViewModel : ProfileViewModel = ProfileViewModel()
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    VStack(spacing:20){
                        HStack{
                            Image("bro")
                            VStack (alignment: .leading){
                                Text("No Allergens Found!")
                                    .fontWeight(.semibold)
                                    .padding(.bottom,2)
                                Text("Start personalizing to identify any potential allergens in your skincare product")
                                    .font(.subheadline)
                            }
                        }
                        
                        NavigationLink(destination: ProfilingInformationView()) {
                            Text("Start Personalization")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .background(Color.customBrown.opacity(0.9))
                                .foregroundColor(.white)
                        }
                        .cornerRadius(10)
                    }
                    .padding(.vertical, 24)
                    
                    VStack {
                        HStack {
                            Text("Your Recent Results")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.customBlack)
                            
                            Spacer()
                            
                            Button{
                                
                            } label: {
                                Text("See More")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.customBrown)
                            }
                        }
                        
                        // HistoryList
                        VStack {
                            ForEach(profileViewModel.fetchHistory(), id:\.self.id) { history in
                                SkinCareProductLongCard(productAnalysisResult: history, productName: "Scan #\(history.id)")
                            }
                        }
                        
                        
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                    
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }
        
    }
}

struct profileViewProvider: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

