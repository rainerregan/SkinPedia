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
                                .background(Color.customBrown)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(10)
                    }
                    .padding(.vertical, 24)
//                    VStack {
//                        VStack{
//                            Text("No allergen have been found.")
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                                .padding(.bottom, 14)
//
//                            Text("Start personalizing to identify any potential allergens in your skincare product")
//                                .font(.subheadline)
//                                .fontWeight(.regular)
//                                .multilineTextAlignment(.center)
//                        }
//                        .frame(width: 296.9)
//                        .padding(.bottom, 21)
//
//
//
//                        Button {
//                            profileViewModel.showProfiling = true
//                        } label: {
//                            Text("Start Personalization")
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 82.5)
//                                .padding(.vertical, 14)
//                                .background(Color.customBrown)
//                                .cornerRadius(12)
//                        }
//                        Spacer()
//                    }
//                    .frame(width: UIScreen.main.bounds.width, height: 228)
//                    .padding(.top, 35)
//                    .background(Color.lightestBrown.opacity(0.4))
//                    .background{
//                        NavigationLink("", destination: ProfilingInformationView(), isActive: $profileViewModel.showProfiling)
//                    }
//                    .padding()
                    
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

